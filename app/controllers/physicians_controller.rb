class PhysiciansController < ApplicationController
  before_action :set_physician, only: %i[ show edit update destroy ]

  # GET /physicians or /physicians.json
  def index
    @search = Physician.ransack(params[:q])
    @pagy, @physicians = pagy(@search.result(distinct: true), items: 10)
  end

  # GET /physicians/1 or /physicians/1.json
  def show
    respond_to do |format|
      format.html
      format.json { render json: @physician.to_json(include: :user) }
    end
  end

  # GET /physicians/new
  def new
    @physician = Physician.new
    @users = User.all
  end

  # GET /physicians/1/edit
  def edit
    @users = User.all
  end

  # POST /physicians or /physicians.json
  def create
    @physician = Physician.new(physician_params)
    @physician.image.attach(params[:physician][:image])

    respond_to do |format|
      if @physician.save
        format.html { redirect_to physician_url(@physician), notice: "Physician was successfully created." }
        format.json { render :show, status: :created, location: @physician }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @physician.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /physicians/1 or /physicians/1.json
  def update
    respond_to do |format|
      if @physician.update(physician_params)
        format.html { redirect_to physician_url(@physician), notice: "Physician was successfully updated." }
        format.json { render :show, status: :ok, location: @physician }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @physician.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /physicians/1 or /physicians/1.json
  def destroy
    @physician.destroy

    respond_to do |format|
      format.html { redirect_to physicians_url, notice: "Physician was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_physician
      @physician = Physician.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def physician_params
      params.require(:physician).permit(:user_id, :image, :degree, :education, :speciality, :experience, :about)
    end
end
