class Api::V1::PlanningsController < Api::V1::AuthenticatedController
  before_action :set_planning, only: [:show, :update, :destroy]

  def index
    available_types = Planning.available_types
    valid_params = %w[action controller type format]
  
    return unless check_unexpected_params(valid_params)
    return unless check_expected_param(:type, available_types)
  
    @plannings = current_user.available_plannings(params[:type])
    current_user.record_achievement('list_plannings_with_python') if python_used
  
    render json: @plannings.map { |planning| { id: planning.hashid, planning_type: planning.planning_type, state: planning.state, published_at: planning.published_at } }
  end

  private

  def check_expected_param(param_name, available_values)
    value = params[param_name]
    if value.present? && !available_values.include?(value)
      render json: { error: "Invalid #{param_name}. Available #{param_name}s are: #{available_values.join(', ')}" }, status: :unprocessable_entity
      return false
    end
    true
  end
  
  def check_unexpected_params(valid_params)
    unexpected_params = params.keys - valid_params
    if unexpected_params.any?
      render json: { error: "Unexpected parameters detected: #{unexpected_params.join(', ')}." }, status: :unprocessable_entity
      return false
    end
    true
  end

  def set_planning
    @planning = Planning.find(params[:id])
  end
end
