class UsersController < ApplicationController
  before_action :require_logged_out
  
  def new
    render :new
  end

  def create
    @user = User.new(user_params)
    @user.save!
    login!(@user)
    redirect_to post_url
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
