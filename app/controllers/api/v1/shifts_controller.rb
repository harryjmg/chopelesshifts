class Api::V1::ShiftsController < Api::V1::ApplicationController
  before_action :require_login
  before_action :set_planning, only: %i[ index ]
  before_action :set_shift, only: %i[ show edit update destroy ]

  # curl -X GET "http://localhost:3000/api/v1/plannings/2/shifts?email=test@test.fr&password=Testi"
  def index
    @shifts = @planning.shifts
    render json: @shifts
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_planning
      @planning = Planning.find(params[:planning_id])
    end
end
