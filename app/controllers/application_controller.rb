class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def prevent_login_signup
  	if session[:user_id]
  		redirect_to root_path, notice: "You are already logged in"
  	end
  end

	def confirm_logged_in
	  redirect_to login_path, alert: "Please Log In" unless session[:user_id]
	end

	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

private

  def find_favorites
    @favorites = Favorite.find_by user_id: @current_user
  end

  def find_user_and_snippet
    @snippet = Snippet.find params[:id]
    @user = @snippet.user_id
  end

  helper_method :current_user #this makes it available for the view

end













