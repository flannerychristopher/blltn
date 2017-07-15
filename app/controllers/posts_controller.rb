class PostsController < ApplicationController
  before_action :logged_in_user,  only: [:create, :destroy]
  before_action :correct_user,    only: [:destroy]
  before_action :user_is_member,  only: [:create]

  def create
    @post = @current_user.posts.build(post_params)
    @board = Board.find(params[:post][:board_id])
    if @post.save
      respond_to do |format|
        format.html { redirect_to @board }
        format.js
      end
    else
      flash[:danger] = "post not created"
      redirect_to @board
    end

  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end

  end

  private

    def post_params
      params.require(:post).permit(:content, :board_id)
    end

    def correct_user
      @post = @current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end

    def user_is_member
      @membership = current_user.memberships.find_by(board_id: params[:post][:board_id])
      @board = Board.find_by(id: params[:post][:board_id])

      redirect_to @board if @membership.nil?
      flash[:danger] = "please join board to post"
    end

end
