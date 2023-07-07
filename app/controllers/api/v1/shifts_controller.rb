class Api::V1::ShiftsController < Api::V1::AuthenticatedController
  before_action :set_planning

  # GET /planning/:planning_id/shifts
  def index
    @shifts = @planning.shifts.map(&:to_api_json)
    render json: @shifts, status: :ok
  end

  private

  def set_planning
    @planning = Planning.find(params[:planning_id])
    unless @planning
      render json: { error: 'Planning not found' }, status: :not_found
    end
  end

end
