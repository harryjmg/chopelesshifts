class Api::V1::PlanningsController < Api::V1::AuthenticatedController
  before_action :set_planning, only: [:show, :update, :destroy]

  # GET /plannings/:planning_id
  def index
    @plannings = current_user.plannings.where(state: "available").or(Planning.where(planning_type: 'weekly', state: 'available')).order(created_at: :desc)

    render json: @plannings.map { |planning| { id: planning.hashid, planning_type: planning.planning_type, state: planning.state, published_at: planning.published_at } }
  end

  private

  def set_planning
    @planning = Planning.find(params[:id])
  end
end
