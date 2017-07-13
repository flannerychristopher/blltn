class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @post = @current_user.posts.build(post_params)
    @board = Board.find(params[:post][:board_id])
    if @post.save
      flash[:success] = "post created"
      redirect_to @board
    else
      #render 'static_pages/home'
    end
  end

  def destroy
  end

  private

    def post_params
      params.require(:post).permit(:content, :board_id)
    end

end
