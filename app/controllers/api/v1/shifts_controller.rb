class Api::V1::ShiftsController < Api::V1::AuthenticatedController
  before_action :set_planning
  before_action :check_and_record_achievements

  # GET /planning/:planning_id/shifts
  def index
    @shifts = @planning.shifts.map(&:to_api_json)
    render json: @shifts, status: :ok
  end

  private

  def check_and_record_achievements
    if @planning.planning_type != 'permanent' && !curl_used
      current_user.record_achievement('fast_listing_without_curl') if Time.now - @planning.published_at < 5.seconds
    end
    current_user.record_achievement('list_shifts_with_python') if python_used
  end

  def set_planning
    @planning = Planning.find(params[:planning_id])
    unless @planning
      render json: { error: 'Planning not found' }, status: :not_found
    end
  end

end
