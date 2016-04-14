class LocationHistoriesController < ApplicationController
  before_action :set_location_history, only: [:show, :edit, :update, :destroy]

  # GET /location_histories
  # GET /location_histories.json
  def index
    @location_histories = LocationHistory.all
  end

  # GET /location_histories/1
  # GET /location_histories/1.json
  def show
  end

  # GET /location_histories/new
  def new
    @location_history = LocationHistory.new
  end

  # GET /location_histories/1/edit
  def edit
  end

  # POST /location_histories
  # POST /location_histories.json
  def create
    @location_history = LocationHistory.new(location_history_params)

    respond_to do |format|
      if @location_history.save
        format.html { redirect_to @location_history, notice: 'Location history was successfully created.' }
        format.json { render :show, status: :created, location: @location_history }
      else
        format.html { render :new }
        format.json { render json: @location_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /location_histories/1
  # PATCH/PUT /location_histories/1.json
  def update
    respond_to do |format|
      if @location_history.update(location_history_params)
        format.html { redirect_to @location_history, notice: 'Location history was successfully updated.' }
        format.json { render :show, status: :ok, location: @location_history }
      else
        format.html { render :edit }
        format.json { render json: @location_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /location_histories/1
  # DELETE /location_histories/1.json
  def destroy
    @location_history.destroy
    respond_to do |format|
      format.html { redirect_to location_histories_url, notice: 'Location history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location_history
      @location_history = LocationHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_history_params
      params.require(:location_history).permit(:pet_id, :record_date, :latitude, :longitude)
    end
end
