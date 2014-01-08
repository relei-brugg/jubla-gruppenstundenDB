class CommentsController < ApplicationController

  before_action :signed_in_user, only: [:create]
  before_action :comment_owner,  only: [:destroy]

  def create
    @idea = Idea.find(params[:idea_id])
    @comment = @idea.comments.new(params[:comment].permit(:text))
    @comment.user = current_user
    @comment.save
    redirect_to idea_path(@idea)
  end

  def destroy
    @idea = Idea.find(params[:idea_id])
    @comment = @idea.comments.find(params[:id])
    @comment.destroy
    redirect_to idea_path(@idea)
  end
end
