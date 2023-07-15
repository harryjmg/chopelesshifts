class Api::V1::ReservationsController < Api::V1::AuthenticatedController
  before_action :set_planning
  before_action :set_shift, only: [:create, :destroy]
  before_action :set_reservation, only: [:destroy]

  # GET /plannings/:planning_id/reservations
  def index
    @reservations = @planning.reservations.where(user: current_user)
    render json: @reservations.map(&:to_api_json)
  end

  # POST /plannings/:planning_id/shifts/:shift_id/reservations
  def create
    @reservation = @shift.reservations.build(user: current_user)

    if @reservation.save
      check_and_record_achievements
      render json: @reservation.to_api_json, status: :created
    else
      render json: { errors: @reservation.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /plannings/:planning_id/shifts/:shift_id/reservations/:id
  def destroy
    if @reservation.user == current_user
      @reservation.destroy
      render json: { message: "Reservation deleted" }, status: :ok
    else
      render json: { error: 'Not Authorized' }, status: :unauthorized
    end
  end

  private

  def check_and_record_achievements
    current_user.record_achievement('first_api_booking')
    if @planning.planning_type == 'weekly'
      current_user.record_achievement('first_api_weekly_booking')
      if current_user.reservations.where(planning: @planning).count >= 14
        current_user.record_achievement('booked_14_slots_via_api')
      end
    end
  end

  def set_planning
    @planning = Planning.find(params[:planning_id])
    unless @planning
      render json: { error: 'Planning not found' }, status: :not_found
    end
  end

  def set_shift
    @shift = @planning.shifts.find(params[:shift_id])
  end

  def set_reservation
    @reservation = @shift.reservations.find_by(user: current_user)
    unless @reservation
      render json: { error: 'Reservation not found' }, status: :not_found
    end
  end
end
