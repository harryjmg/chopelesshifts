class ShiftsController < ApplicationController
  before_action :require_login
  before_action :set_shift, only: %i[ show ]

  # GET /shifts/1 or /shifts/1.json
  def show
    @user_shifts = current_user.shifts.where(planning_id: @shift.planning.id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shift
      @planning = Planning.find(params[:planning_id])
      @shift = @planning.shifts.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def shift_params
      params.require(:shift).permit(:planning_id, :day, :start_hour, :end_hour, :seats)
    end
end
