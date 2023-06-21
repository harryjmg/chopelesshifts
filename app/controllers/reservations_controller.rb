class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[ show edit update destroy ]

  # GET /reservations or /reservations.json
  def index
    @reservations = current_user.reservations
  end

  # GET /reservations/1 or /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations or /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)
    @shift = @reservation.shift
    @user_shifts = current_user.shifts.where(planning_id: @shift.planning.id)

    if @reservation.save
      render turbo_stream: turbo_stream.replace(
        "shift_#{@shift.id}",
        partial: 'reservations/create',
        locals: { shift: @shift, reservation: @reservation, user_shifts: @user_shifts }
      )
    else
      puts "ERROR"
    end
  end

  # PATCH/PUT /reservations/1 or /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to reservation_url(@reservation), notice: "Reservation was successfully updated." }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1 or /reservations/1.json
  def destroy
    @user_shifts = current_user.shifts.where(planning_id: @reservation.shift.planning.id)
    @shift = @reservation.shift
    @planning = @shift.planning
    @reservation.destroy

    render turbo_stream: turbo_stream.replace(
      "shift_#{@shift.id}",
      partial: 'reservations/destroy',
      locals: { shift: @shift, reservation: @reservation, user_shifts: @user_shifts }
    )
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
