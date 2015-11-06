class FavoritesController < ApplicationController
	before_action :current_user
	before_action :find_favorites

	def index
	    @user = User.find params[:id]
		@favorites = @user.snippets
	end

	def create
		@favorite = Favorite.new(favorite_params)
		if @favorite.save
			redirect_to favorites_path, flash: {success: "Successfully Created!"}
		else
			render :new
		end
	end

	def update
		@favorite = Favorite.find params[:id]
		@favorite.update favorite_params
		redirect_to favorites_path
		if @favorite.save
			redirect_to favorite_path(@favorite), notice: "Updated"
		else
			render :edit
		end
	end

	def destroy
		@favorite = Favorite.find_by_id params[:id]
		@favorite.destroy
		redirect_to favorites_path
	end

	private

	def favorite_params
		params.require(:favorite).permit(:user_id, :snippet_id)
	end

  def find_favorites
    @user = @current_user
    @favorites = @user.favorites
  end

end