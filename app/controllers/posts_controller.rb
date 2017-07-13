class PostsController < ApplicationController
  before_action :logged_in_user,  only: [:create, :destroy]
  before_action :correct_user,    only: :destroy

  def create
    @post = @current_user.posts.build(post_params)
    @board = Board.find(params[:post][:board_id])
    if @post.save
      flash[:success] = "post created"
      #redirect_to @board
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

end
