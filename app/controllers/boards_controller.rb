class BoardsController < ApplicationController
  before_action :logged_in_user,        only: [:new, :create, :edit, :update]
  before_action :admin_membership,      only: [:edit, :update]

  def index
    @boards = Board.all
  end

  def new
    @board = Board.new
  end

  def show
    @board = Board.find(params[:id])
    @post = Post.new
    @admins = @board.memberships.where(admin: true)

    if logged_in? && @board.users.include?(current_user)
      @membership = Membership.find_by(board_id: params[:id],
                               user_id: current_user.id)
    else
      @membership = Membership.new
    end

  end

  def create
   @board = Board.new(board_params)
   if @board.save
     create_admin(current_user)
     flash[:success] = "board created"
     redirect_to board_path(@board)
   else
     render 'new'
   end
  end

  def edit
  end

  def update
    @board = Board.find(params[:id])
    if @board.update_attributes(board_params)
      flash[:success] = "Board updated"
      redirect_to @board
    else
      render 'edit'
    end
  end

  private

    def board_params
      params.require(:board).permit(:name, :info)
    end

    # make current_user an admin when creating a board
    def create_admin(user)
      Membership.create(board_id: @board.id, user_id: user.id, admin: true)
    end

    def current_membership
      @current_membership = Membership.find_by(board_id: params[:id].to_i, user_id: current_user.id)
    end

    def admin_membership
      @board = Board.find(params[:id])

      if logged_in? && @board.users.include?(current_user)
        @membership = Membership.find_by(board_id: params[:id],
                                user_id: current_user.id)
      else
        @membership = Membership.new
      end

      redirect_to(root_url) unless @membership.admin?
    end

 end
