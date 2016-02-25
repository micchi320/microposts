class UsersController < ApplicationController
  before_action :commonLogin, only: [:edit,:update]

  def show
   @user = User.find(params[:id])
   @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user # ここを修正
    else
      render 'new'
    end
  end
  
  def edit
    render 'edit'
  end
  
  def update
    @user.update(user_params)
    flash[:seccess] = "Successfully updated"
    redirect_to @user
  end
  
  def followings
  end
  
  def followers
  end
  

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :age, :area)
  end
  
  def commonLogin
    @user = User.find(params[:id])
    unless logged_in? && current_user == @user
    then
      # ログインユーザーとは異なる
      flash[:alert] = "エラー"
      redirect_to root_url
    end
  end
  
end