class RoomsController < ApplicationController
  def index
    @rooms = Room.public_room
    @users = User.all_except(current_user)
  end

  def show
    @single_room = Room.find(params[:id])

    @rooms = Room.public_room
    @users = User.all_except(current_user)

    render 'index'
  end
end
