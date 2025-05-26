class CommentsController < ApplicationController
  before_action :set_comment, only: [:update, :destroy]
  before_action :authorize_owner!, only: [:update, :destroy]

  def create
    post = Post.find(params[:post_id])
    comment = post.comments.build(body: params[:body], user: @current_user)

    if comment.save
      render json: comment, status: :created
    else
      render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(body: params[:body])
      render json: @comment
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    head :no_content
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  rescue
    render json: { error: 'Comment not found' }, status: :not_found
  end

  def authorize_owner!
    render json: { error: 'Unauthorized' }, status: :unauthorized unless @comment.user_id == @current_user.id
  end
end

