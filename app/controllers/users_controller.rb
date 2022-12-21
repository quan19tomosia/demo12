class UsersController < ApplicationController
  before_action :set_user, only: %i[ ban ]
  def index
    @search = User.ransack(params[:q])
    @pagy, @users = pagy(@search.result(distinct: true).order(created_at: :asc), items: 10)
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  def ban
    if @user.access_locked?
      @user.unlock_access!
    else
      @user.lock_access!
    end
    redirect_to users_path, notice: "Active changed successfully"
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
    end
end
