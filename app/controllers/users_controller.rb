class UsersController < ApplicationController
  before_action :current_user
  before_action :find_user, only: [:show, :edit, :update, :delete]
  before_action :prevent_login_signup, only: [:create]

  def signup
    edirect_to login_path
  end

  def create
    @user = User.create user_params
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'Successfully created!'
      redirect_to root_path
    else
      render :signup
    end
  end

  def show
    if @current_user.id != @user.id
      redirect_to root_path
    end
  end

  def edit
    if @current_user.id != @user.id
      redirect_to root_path
    end
  end

  def update
    @user.update user_params
    if @user.save
      flash[:notice] = "Account updated"
      redirect_to user_path(@user)
    else
      render :edit
    end

  end

  def delete
    @user.destroy && session[:user_id] = nil
    flash[:notice] = "Account deleted, You have been logged out"
    redirect_to root_path
  end


  private

  def find_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit(
      :username,
      :email,
      :password
    )
  end

  def ensure_logged_in
    unless session[:id]
      redirect_to login_path, alert: "Please log in"
    end
  end
end
