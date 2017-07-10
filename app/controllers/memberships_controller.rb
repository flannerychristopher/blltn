class MembershipsController < ApplicationController

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

  end
