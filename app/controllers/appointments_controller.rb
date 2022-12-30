class AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[ show edit update destroy ]
  before_action :set_select_collections, only: [:new, :create, :edit, :update]

  # GET /appointments or /appointments.json
  def index
    @search = Appointment.ransack(params[:q])
    @pagy, @appointments = pagy(@search.result(distinct: true).order(schedule: :desc), items: 10)

    respond_to do |format|
      format.html
      format.csv { send_data Appointment.all.to_csv, filename: "appointments-#{Date.today}.csv" }
    end
  end

  # GET /appointments/1 or /appointments/1.json
  def show
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments or /appointments.json
  def create
    @appointment = Appointment.new(appointment_params)

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to appointment_url(@appointment), flash: { success: "Appointment was successfully created." }}
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
      format.html { redirect_to appointments_url, flash: { danger: "Appointment was successfully destroyed." }}
      format.json { head :no_content }
    end
  end
  
  def change_state
    @appointment = Appointment.find(params[:appointment_id])
    respond_to do |format|
      if @appointment.update(state: params[:state])
        format.html { redirect_to appointment_url(@appointment), notice: "Appointment was successfully changed state." }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
    # @appointment.update_column(state: state)
  end

  def check
    date = params[:date].to_date

    @times = Appointment.where(physician_id: params[:physician_id]).where(schedule: date.beginning_of_day..date.end_of_day).pluck(:schedule)
    @times = @times.map { |e| e.strftime("%H:%M")} unless @times.nil?
    
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
      params.require(:appointment).permit(:service_id, :patient_id, :physician_id, :schedule_day, :schedule_time)
    end

    def set_select_collections
      @services = Service.where(status: Service.statuses[:active]).map { |service| [service.name, service.id] }
      @patients = Patient.includes(:user).where(user: { locked_at: nil }).map { |patient| [patient.user.name, patient.id] }
      @physicians = Physician.includes(:user).where(user: { locked_at: nil }).map { |physician| [physician.user.name, physician.id] }
    end
end
