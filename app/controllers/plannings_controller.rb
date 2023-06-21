class PlanningsController < ApplicationController
  before_action :require_login
  before_action :set_planning, only: %i[ show edit update destroy ]

  # GET /plannings or /plannings.json
  def index
    @plannings = Planning.all
  end

  # GET /plannings/1 or /plannings/1.json
  def show
    @user_shifts = current_user.shifts.where(planning_id: @planning.id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_planning
      @planning = Planning.find(params[:id])
    end
end
