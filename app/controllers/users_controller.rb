class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.js { render partial: 'users/show.js' }
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "welcome to blltn"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    respond_to do |format|
      format.js { render 'users/edit.js' }
    end
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(user_params)
        flash.now[:success] = "Profile updated"
        format.js { render 'users/update.js'  }
      end
    end
  end

  private

      def user_params
        params.require(:user).permit(:name, :email, :bio, :password,
                                     :password_confirmation, :avatar)
      end

end
