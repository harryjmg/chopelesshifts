class ReservationsController < ApplicationController
  before_action :require_login
  before_action :set_reservation, only: %i[ destroy ]

  # POST /reservations or /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)
    @shift = @reservation.shift
    @user_shifts = current_user.shifts.where(planning_id: @shift.planning.id)

    if @reservation.save
      current_user.record_achievement('first_booking')
      current_user.record_achievement('first_weekly_booking') if @shift.planning.planning_type == 'weekly'
      redirect_to planning_shift_url(@shift.planning, @shift), notice: "La réservation a été faite avec succès."
    else
      redirect_to planning_shift_url(@shift.planning, @shift), notice: "La réservation a échoué."
    end
  end

  # DELETE /reservations/1 or /reservations/1.json
  def destroy
    shift = @reservation.shift
    planning = shift.planning
    @reservation.destroy

    respond_to do |format|
      format.html { redirect_to planning_shift_url(planning, shift), notice: "La réservation a été annulée avec succès." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reservation_params
      params.require(:reservation).permit(:user_id, :shift_id, :speed_in_ms)
    end
end
