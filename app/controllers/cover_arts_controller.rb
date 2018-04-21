class CoverArtsController < ApplicationController
  before_action :set_cover_art, only: [:show, :edit, :update, :destroy]

  # GET /cover_arts
  # GET /cover_arts.json
  def index
    @cover_arts = CoverArt.all
  end

  # GET /cover_arts/1
  # GET /cover_arts/1.json
  def show
  end

  # GET /cover_arts/new
  def new
    @cover_art = CoverArt.new
  end

  # GET /cover_arts/1/edit
  def edit
  end

  # POST /cover_arts
  # POST /cover_arts.json
  def create
    @cover_art = CoverArt.new(cover_art_params)

    respond_to do |format|
      if @cover_art.save
        format.html { redirect_to @cover_art, notice: 'Cover art was successfully created.' }
        format.json { render :show, status: :created, location: @cover_art }
      else
        format.html { render :new }
        format.json { render json: @cover_art.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cover_arts/1
  # PATCH/PUT /cover_arts/1.json
  def update
    respond_to do |format|
      if @cover_art.update(cover_art_params)
        format.html { redirect_to @cover_art, notice: 'Cover art was successfully updated.' }
        format.json { render :show, status: :ok, location: @cover_art }
      else
        format.html { render :edit }
        format.json { render json: @cover_art.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cover_arts/1
  # DELETE /cover_arts/1.json
  def destroy
    @cover_art.destroy
    respond_to do |format|
      format.html { redirect_to cover_arts_url, notice: 'Cover art was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cover_art
      @cover_art = CoverArt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cover_art_params
      params.fetch(:cover_art, {})
    end
end
