class SynopsesController < ApplicationController
  before_action :set_synopsis, only: [:show, :edit, :update, :destroy]

  # GET /synopses
  # GET /synopses.json
  def index
    @synopses = Synopsis.all
  end

  # GET /synopses/1
  # GET /synopses/1.json
  def show
  end

  # GET /synopses/new
  def new
    @synopsis = Synopsis.new
  end

  # GET /synopses/1/edit
  def edit
  end

  # POST /synopses
  # POST /synopses.json
  def create
    @synopsis = Synopsis.new(synopsis_params)

    respond_to do |format|
      if @synopsis.save
        format.html { redirect_to @synopsis, notice: 'Synopsis was successfully created.' }
        format.json { render :show, status: :created, location: @synopsis }
      else
        format.html { render :new }
        format.json { render json: @synopsis.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /synopses/1
  # PATCH/PUT /synopses/1.json
  def update
    respond_to do |format|
      if @synopsis.update(synopsis_params)
        format.html { redirect_to @synopsis, notice: 'Synopsis was successfully updated.' }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_synopsis
      @synopsis = Synopsis.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def synopsis_params
      params.fetch(:synopsis, {})
    end
end
