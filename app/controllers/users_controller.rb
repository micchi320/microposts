class UsersController < ApplicationController
  before_action :show, only: [:edit, :update, :destroy]
  
  def show # 追加
   @user = User.find(params[:id])
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
    if logged_in? && current_user == @user
  # ログインユーザーとおなじ
      render 'edit'
    else
  # ログインユーザーとは異なる
      flash[:alert] = "Editing Failed"
      redirect_to root_path
    end
  end
  
  def update
    if @user.update(user_params)
      flash[:seccess] = "Successfully updated"
    # 保存に成功した場合はプロフィールへリダイレクト
      redirect_to @user
    else
      flash[:alert] = "Updating Failed"
      render 'edit'
    end
  end
  
  #def destroy
  #  @user.destroy
  #  redirect_to root_path, notice: 'ログアウトしました'
  #end
  

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :age, :area)
  end
  
end
