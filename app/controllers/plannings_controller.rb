class PlanningsController < ApplicationController
  before_action :set_planning, only: %i[ show edit update destroy ]

  # GET /plannings or /plannings.json
  def index
    @plannings = Planning.all
  end

  # GET /plannings/1 or /plannings/1.json
  def show
  end

  # GET /plannings/new
  def new
    @planning = Planning.new
  end

  # GET /plannings/1/edit
  def edit
  end

  # POST /plannings or /plannings.json
  def create
    @planning = Planning.new(planning_params)

    respond_to do |format|
      if @planning.save
        format.html { redirect_to planning_url(@planning), notice: "Planning was successfully created." }
        format.json { render :show, status: :created, location: @planning }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @planning.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plannings/1 or /plannings/1.json
  def update
    respond_to do |format|
      if @planning.update(planning_params)
        format.html { redirect_to planning_url(@planning), notice: "Planning was successfully updated." }
        format.json { render :show, status: :ok, location: @planning }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @planning.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plannings/1 or /plannings/1.json
  def destroy
    @planning.destroy

    respond_to do |format|
      format.html { redirect_to plannings_url, notice: "Planning was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_planning
      @planning = Planning.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def planning_params
      params.require(:planning).permit(:name, :type, :state)
    end
end
