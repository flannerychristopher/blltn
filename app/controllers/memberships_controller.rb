class MembershipsController < ApplicationController
  before_action :logged_in_user,    only: [:create, :destroy]
  before_action :correct_user,      only: :destroy

  def new
  end

  def create
    Membership.create!(membership_params)
    @board = Board.find(params[:membership][:board_id])
    respond_to do |format|
      format.html { redirect_to @board }
      format.js
    end
  end

  def destroy
    # Membership.find(params[:id]).destroy
    @board = Board.find(params[:membership][:board_id])
    membership = Membership.find_by(user_id: @current_user.id, board_id: @board.id)
    membership.destroy if !membership.admin?
    respond_to do |format|
      format.html { redirect_to @board }
      format.js
    end
  end

  private

    def membership_params
      params.require(:membership).permit(:user_id, :board_id)
    end

    def correct_user
      @membership = current_user.memberships.find_by(id: params[:id])
      redirect_to root_url if @membership.nil?
    end

  end
