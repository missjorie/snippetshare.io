class SnippetsController < ApplicationController

	before_action :find_user, only: [:index, :new, :create]
	before_action :find_user_and_snippet, only: [:edit, :update, :destroy]

	def index
		@snippets = @user.snippets
	    @languages = Language.all
	    @editors = Editor.all
	    @users = User.all
	end

	def new
		@snippet = @user.snippets.new
		@languages = Language.all
		@editors = Editor.all
		# @user = User.first # this is only for tests
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
		@snippet.destroy
		redirect_to user_snippets_path(@user)
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
end
