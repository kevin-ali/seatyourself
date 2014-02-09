class UsersController < ApplicationController

  before_filter :ensure_logged_in

  def index
    @user = current_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to restaurants_url, :notice => "Signed up!"
    else
      render "new"
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to restaurants_path
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end



end
