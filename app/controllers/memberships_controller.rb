class MembershipsController < ApplicationController
  before_action :logged_in_user,    only: [:create, :destroy]
  before_action :correct_user,      only: :destroy

  def new
    # @membership = Membership.new
  end

  def create
    Membership.create!(membership_params)
  end

  def destroy
    # Membership.find(params[:id]).destroy
    # redirect_to users_url
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
