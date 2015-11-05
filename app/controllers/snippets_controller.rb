class SnippetsController < ApplicationController
	def index
		@user = User.find params[:user_id]
		@snippets = @user.snippets
	end

	def new
		@user = User.find params[:user_id]
		@snippet = @user.snippets.new
		@languages = Language.all
		@editors = Editor.all
		# @user = User.first # this is only for tests
	end

	def create
		@user = User.find params[:user_id]
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

		@snippet = Snippet.find params[:id]
		@user = @snippet.user_id
		@languages = Language.all
		@editors = Editor.all
		@snippet = Snippet.find params[:id]
	end

	def update
		@snippet = Snippet.find params[:id]
		@user = @snippet.user_id
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
		# @snippets = @user.snippets
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
# redirect_to user_snippets_path(@user)


private

def snippet_params
	params.require(:snippet).permit(:name, :code, :description, :user_id, :language_id, :editor_id)
end
