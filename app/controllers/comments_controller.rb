class CommentsController < ApplicationController
	before_action :set_comment, only:[:show, :edit, :update, :destroy]
	before_action :set_pic
	before_action :authenticate_user!


	def create
		@comment = Comment.new(comment_params)
		@comment.user_id = current_user.id
		@comment.pic_id = @pic.id
		if @comment.save
		   redirect_to pic_path(@pic)
		else
			render 'new'
		end
	end

	def index
		@comments = Comment.all	
	end

	def show
	end

	def new
		@comment = Comment.new	
	end


	def destroy
		@comment.destroy
		redirect_to pic_path(@pic)
	end

	def update
		@comment.update(comment_params)
		redirect_to pic_path(@pic)
	end


	private 
	def comment_params
		params.require(:comment).permit(:content)	
	end

	def set_comment
		@comment = Comment.find(params[:id])
	end

	def set_pic
		@pic = Pic.find(params[:pic_id])
	end
end
