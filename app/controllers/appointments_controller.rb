class AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[ show edit update destroy ]

  # GET /appointments or /appointments.json
  def index
    @search = Appointment.ransack(params[:q])
    @pagy, @appointments = pagy(@search.result(distinct: true).order(schedule: :desc), items: 10)
  end

  # GET /appointments/1 or /appointments/1.json
  def show
  end

  # GET /appointments/new
  def new
    @services = Service.where(status: Service.statuses[:active])
    @patients = Patient.includes(:user).where(user: { locked_at: nil }).map { |patient| [patient.user.name, patient.id] }
    @physicians = Physician.includes(:user).where(user: { locked_at: nil }).map { |physician| [physician.user.name, physician.id] }
    @appointment = Appointment.new
  end

  # GET /appointments/1/edit
  def edit
    @services = Service.where(status: Service.statuses[:active])
    @patients = Patient.all
    @physicians = Physician.all
  end

  # POST /appointments or /appointments.json
  def create
    @appointment = Appointment.new(appointment_params)

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to appointment_url(@appointment), notice: "Appointment was successfully created." }
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointments/1 or /appointments/1.json
  def update
    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to appointment_url(@appointment), notice: "Appointment was successfully updated." }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1 or /appointments/1.json
  def destroy
    @appointment.destroy

    respond_to do |format|
      format.html { redirect_to appointments_url, notice: "Appointment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def check
    date = params[:date].to_date

    @times = Appointment.where(physician_id: params[:physician_id]).where(schedule: date.beginning_of_day..date.end_of_day).pluck(:schedule)
    @times = @times.map { |e| e.strftime("%I:%M%p")} unless @times.nil?
    
    respond_to do |format|
      format.json { render json: @times.to_json }
      format.html
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def appointment_params
      params.require(:appointment).permit(:service_id, :patient_id, :physician_id, :schedule)
    end
end
