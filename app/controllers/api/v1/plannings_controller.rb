class Api::V1::PlanningsController < Api::V1::ApplicationController
  before_action :require_login

  # curl -X GET "http://localhost:3000/api/v1/plannings?email=test@test.fr&password=Testi"
  def index
    @plannings = Planning.all
    render json: @plannings
  end

end
