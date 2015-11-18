class SnippetsController < ApplicationController
	before_action :current_user, :find_favorites
	before_action :find_user, only: [:index, :new, :create]
	before_action :find_user_and_snippet, only: [:edit, :update, :destroy]

	def index
		@snippets = @user.snippets
	    @languages = Language.all
	    @editors = Editor.all
	    @users = User.all
	    @user = User.find params[:user_id]
	end

	def new
		@snippet = @user.snippets.new
		@languages = Language.all
		@editors = Editor.all
		if @current_user.id != @snippet.user_id
			redirect_to root_path
		end
	end

	def create
		@snippet = @user.snippets.new(snippet_params)
		@languages = Language.all
		@editors = Editor.all
		if @snippet.save
			redirect_to user_snippets_path params[:user_id]
		else
			render :new
		end
	end

	def show
		@snippet = Snippet.find params[:id]
		@user = User.find @snippet.user_id
		@language = Language.find @snippet.language_id
		@editor = Editor.find @snippet.editor_id
	end

	def edit
		@languages = Language.all
		@editors = Editor.all
		@snippet = Snippet.find params[:id]
		if @current_user.id != @snippet.user_id
			redirect_to root_path
		end
	end

	def update
		@languages = Language.all
		@editors = Editor.all
		@snippet = Snippet.find params[:id]
		@snippet.update snippet_params
		if @snippet.save
			redirect_to user_snippets_path(@user)
		else
			render :new
		end
	end

	def destroy
		@snippet = Snippet.find params[:id]
		@user = @snippet.user_id
		if @snippet.destroy
			respond_to do |f|
				f.html { redirect_to user_snippets_path(@user), notice: 'Snippet has been deleted.'}
				f.js {}
				f.json { render json: @snippet, status: :deleted, location: @snippet }
			end
		else
			f.html {render action: "index"}
			f.json { render json: @snippet.errors, status: :unprocessable_entity }
		end
	end
end
#favorites
	def create_favorite
		@favorite = Favorite.new(favorite_params)
		if @favorite.save
			respond_to do |f|
				f.html { redirect_to user_favorites_path(@user)}
				f.js {}
				f.json { render json: @favorite, status: :created, location: @favorite }
			end
		else
			f.html {render action: "create_favorite"}
			f.json { render json: @favorite.errors, status: :unprocessable_entity }
		end
	end

	def destroy_favorite
		@favorite = Favorite.find_by_id params[:id]
		if @favorite.destroy
			respond_to do |f|
				f.html { redirect_to user_favorites_path(@user)}
				f.js {}
				f.json { render json: @favorite, status: :deleted, location: @favorite }
			end
		else
			f.html {render action: "destroy_favorite"}
			f.json { render json: @favorite.errors, status: :unprocessable_entity }
		end
	end

private

	def find_user
		@user = User.find params[:user_id]
	end

	def find_user_and_snippet
		@snippet = Snippet.find params[:id]
		@user = @snippet.user_id
	end

	def snippet_params
		params.require(:snippet).permit(:name, :code, :description, :user_id, :language_id, :editor_id)
	end

