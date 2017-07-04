class GroupsController < ApplicationController

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
  end

  def create
    # @group = Group.new(group_params)
    # if @group.save
    #   #@group.users << current_user
    #
    #   redirect_to group_path(@group)
    # else
    #   render 'new'
    # end
  end

  def destroy
  end

  private

    def group_params
      params.require(:group).permit(:name)
    end
end
