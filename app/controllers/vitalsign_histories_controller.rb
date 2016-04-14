class VitalsignHistoriesController < ApplicationController
  before_action :set_vitalsign_history, only: [:show, :edit, :update, :destroy]

  # GET /vitalsign_histories
  # GET /vitalsign_histories.json
  def index
    @vitalsign_histories = VitalsignHistory.all
  end

  # GET /vitalsign_histories/1
  # GET /vitalsign_histories/1.json
  def show
  end

  # GET /vitalsign_histories/new
  def new
    @vitalsign_history = VitalsignHistory.new
  end

  # GET /vitalsign_histories/1/edit
  def edit
  end

  # POST /vitalsign_histories
  # POST /vitalsign_histories.json
  def create
    @vitalsign_history = VitalsignHistory.new(vitalsign_history_params)

    respond_to do |format|
      if @vitalsign_history.save
        format.html { redirect_to @vitalsign_history, notice: 'Vitalsign history was successfully created.' }
        format.json { render :show, status: :created, location: @vitalsign_history }
      else
        format.html { render :new }
        format.json { render json: @vitalsign_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vitalsign_histories/1
  # PATCH/PUT /vitalsign_histories/1.json
  def update
    respond_to do |format|
      if @vitalsign_history.update(vitalsign_history_params)
        format.html { redirect_to @vitalsign_history, notice: 'Vitalsign history was successfully updated.' }
        format.json { render :show, status: :ok, location: @vitalsign_history }
      else
        format.html { render :edit }
        format.json { render json: @vitalsign_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vitalsign_histories/1
  # DELETE /vitalsign_histories/1.json
  def destroy
    @vitalsign_history.destroy
    respond_to do |format|
      format.html { redirect_to vitalsign_histories_url, notice: 'Vitalsign history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vitalsign_history
      @vitalsign_history = VitalsignHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vitalsign_history_params
      params.require(:vitalsign_history).permit(:pet_id, :record_date, :breathing_freq, :heart_freq, :systolic, :diastolic)
    end
end
