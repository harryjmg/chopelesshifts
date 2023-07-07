class PlanningsController < ApplicationController
  before_action :require_login
  # GET /plannings or /plannings.json
  def index
    @permanent_planning = current_user.plannings.where(planning_type: 'permanent', state: 'available').first
    @daily_planning = current_user.plannings.where(state: 'available', planning_type: 'daily').order(published_at: :desc).first
    @weekly_planning = Planning.where(planning_type: 'weekly', state: 'available').order(published_at: :desc).first

    @available_plannings = [@permanent_planning, @daily_planning, @weekly_planning].compact

    # @available_plannings = Planning.available_plannings.sort_by(&:order_by_type)
    @closed_plannings = Planning.closed_plannings.where(planning_type: 'weekly').sort_by(&:published_at).reverse
  end

  # GET /plannings/1 or /plannings/1.json
  def show
    @planning = Planning.find(params[:id])
    @user_shifts = current_user.shifts.where(planning_id: @planning.id)
  end
end
