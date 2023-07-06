class Api::V1::ReservationsController < Api::V1::AuthenticatedController
  before_action :require_login

  # GET /reservations or /reservations.json
  def index
    @reservations = current_user.reservations
    render json: @reservations
  end

  # curl -X POST -H "Content-Type: application/json" \
  # -d '{"email": "test@test.fr", "password": "Testi", "shift_id": "1"}' \
  # http://localhost:3000/api/v1/plannings/2/reservations
  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      render json: @reservation, status: :created
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end

  end

  # curl -X DELETE -H "Content-Type: application/json" \
  # -d '{"email": "test@test.fr", "password": "Testi"}' \
  # http://localhost:3000/api/v1/plannings/2/reservations/3
  def destroy
    @reservation = Reservation.find(params[:id])
    if @reservation.nil?
      render json: { error: "Reservation not found" }, status: :not_found
    end

    @reservation.destroy

    render json: @reservation, status: :ok
  end

  private
    # Only allow a list of trusted parameters through.
    def reservation_params
      params[:reservation][:user_id] = current_user.id
      params[:reservation][:shift_id] = params[:shift_id]
      params.require(:reservation).permit(:user_id, :shift_id)
    end
end
