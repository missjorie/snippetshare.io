class FavoritesController < ApplicationController
	before_action :current_user, :find_favorites

		def create
		    @favorite = Favorite.create(favorite_params)
		    # if @favorite.save
		    #   redirect_to favorites_path, flash: {success: "Successfully Created!"}
		    # else
		    #   render :new
		    # end
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




end
