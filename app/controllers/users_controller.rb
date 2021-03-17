class UsersController < ApplicationController

  skip_before_action :login_required, only: [:new, :create]
  before_action :set_user, only: [:show]

  def new
    if logged_in?
      flash.now[:danger] = 'ログイン中のため新規登録はできません'
      redirect_to user_path(current_user.id)
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    redirect_to tasks_path unless user_path(@user.id) == user_path(current_user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
