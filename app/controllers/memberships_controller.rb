class MembershipsController < ApplicationController
  before_action :logged_in_user,    only: [:create, :destroy]
  before_action :correct_user,      only: :destroy

  def create
    @membership = Membership.create!(membership_params)
    @board = @membership.board
    @users = @board.users
    respond_to do |format|
      format.js { render partial: 'memberships/destroy' }
    end
  end

  def destroy
    @board = @membership.board
    @users = @board.users
    @membership.destroy unless @membership.admin?
    respond_to do |format|
      format.js { render partial: 'memberships/create' }
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
