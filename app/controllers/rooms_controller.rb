class RoomsController < ApplicationController
  before_action :set_room, only: %i[ show edit update destroy ]

  def index
    @rooms = Room.public_room
    @users = User.all_except(current_user)
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        format.html { redirect_to rooms_path, noitice: "Channel was successfully created." }
        format.json { render :index }
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def show
    @single_room = Room.find(params[:id])

    @rooms = Room.public_room
    @users = User.all_except(current_user)

    render 'index'
  end

  private
    def set_room
      @room = Room.find(params[:id])
    end

    def room_params
      params.require(:room).permit(:name)
    end
end
