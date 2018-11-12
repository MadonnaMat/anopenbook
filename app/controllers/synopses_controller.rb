# frozen_string_literal: true

class SynopsesController < ApplicationController
  include LastPage

  before_action :set_book
  before_action :set_synopsis, only: %i[show edit update destroy vote]
  before_action :check_user_signed_in, only: %i[new edit create update vote]
  before_action :redirect_if_exists, only: %i[new create]
  before_action :redirect_if_published, only: %i[edit update]
  before_action :redirect_unless_friendly

  # GET /synopses
  # GET /synopses.json
  def index
    redirect_to url_for(request.parameters.merge(seed: rand, only_path: true)) unless params[:seed]
    page = params[:page] if request.format.json?
    page ||= 1
    seed = params[:seed].to_f
    Synopsis.select("setseed(#{seed})").first
    @synopses = Synopsis.where(book_id: @book.id)
                        .submitted
                        .order('random()')
                        .page(page)
                        .per(10)
    @synopses_complete = last_page? @synopses
    @existing = existing_synopsis

    setup_votes

    respond_to do |format|
      format.html
      format.json do
        render json: SubmissionSerializer.new(@synopses,
                                              params: { current_user: current_user },
                                              meta: {
                                                last: @synopses_complete
                                              }).to_json
      end
    end
  end

  # GET /synopses/1
  # GET /synopses/1.json
  def show; end

  # GET /synopses/new
  def new
    @synopsis = Synopsis.new
  end

  # GET /synopses/1/edit
  def edit; end

  # POST /synopses
  # POST /synopses.json
  def create
    @synopsis = current_user.synopses.for_book(@book).new(synopsis_params)
    @synopsis.is_submitted = params.key?(:publish)

    respond_to do |format|
      if @synopsis.save
        flash[:success] = I18n.t('synopsis.created')
        format.html do
          if @synopsis.is_submitted?
            redirect_to controller: 'synopses', action: 'show', id: @synopsis.id, book_id: @book.id
          else
            redirect_to controller: 'synopses', action: 'edit', id: @synopsis.id, book_id: @book.id
          end
        end
        format.json { render :edit, status: :created, location: @synopsis }
      else
        flash[:error] = @synopsis.errors
        format.html { render :new }
        format.json { render json: @synopsis.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /synopses/1
  # PATCH/PUT /synopses/1.json
  def update
    @synopsis.is_submitted = params.key?(:publish)

    @synopsis.slug = nil if synopsis_params[:title] != @synopsis.title

    respond_to do |format|
      if @synopsis.update(synopsis_params)
        format.html do
          if @synopsis.is_submitted?
            redirect_to controller: 'synopses', action: 'show', id: @synopsis.id, book_id: @book.id
          else
            redirect_to controller: 'synopses', action: 'edit', id: @synopsis.id, book_id: @book.id
          end
        end
        format.json { render :show, status: :ok, location: @synopsis }
      else
        format.html { render :edit }
        format.json { render json: @synopsis.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /synopses/1
  # DELETE /synopses/1.json
  def destroy
    @synopsis.destroy
    respond_to do |format|
      format.html { redirect_to synopses_url, notice: 'Synopsis was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def vote
    setup_votes

    if @book.voting_enabled?
      if current_user.voted_for? @synopsis
        @synopsis.unliked_by current_user
        @votes_left += 1
      elsif @votes_left > 0
        @synopsis.liked_by current_user
        @votes_left -= 1
      end
    end

    render json: SubmissionSerializer.new(@synopsis,
                                          params: { current_user: current_user },
                                          meta: { votes_left: @votes_left }).to_json
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_synopsis
    @synopsis = Synopsis.friendly.find(params[:id])
  end

  def set_book
    @book = Book.friendly.find(params[:book_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def synopsis_params
    params.fetch(:synopsis).permit(:title, :body)
  end

  def check_user_signed_in
    unless user_signed_in?
      flash[:error] = I18n.t('user.not_logged_in')
      redirect_to book_url(@book)
    end
  end

  def redirect_unless_friendly
    redirect = params[:book_id] != @book.friendly_id
    redirect ||= params[:id] != @synopsis.friendly_id if @synopsis
    redirect_to(action: action_name, controller: 'synopses', book_id: @book.friendly_id, id: @synopsis.try(:friendly_id)) if redirect
  end

  def redirect_if_exists
    synopsis = existing_synopsis
    if synopsis
      redirect_to(action: 'edit', controller: 'synopses', book_id: @book.friendly_id, id: synopsis.friendly_id)
    end
  end

  def redirect_if_published
    if @synopsis.is_submitted?
      flash[:error] = I18n.t('synopsis.already_published')
      redirect_to(action: 'show', controller: 'synopses', book_id: @book.friendly_id, id: @synopsis.try(:friendly_id))
    end
  end

  def existing_synopsis
    current_user.synopses.for_book(@book).first
  end

  def setup_votes
    @votes_left = 5 - @book.get_user_votes(current_user, Synopsis).count if @book.voting_enabled?
  end
end
