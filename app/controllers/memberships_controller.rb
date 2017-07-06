class MembershipsController < ApplicationController

  def create
      Membership.create!(membership_params)
  end

  private

    def membership_params
      params.require(:membership).permit(:user_id, :board_id)
    end

  end
