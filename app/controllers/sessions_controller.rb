class SessionsController < ApplicationController
  # before_action :require_logged_in, only:[:destroy]
  before_action :require_logged_out, only:[:new, :create]
  # before_action

  def new
    render :new
  end

  def create
    login_user!
  end

  def destroy
    current_user.reset_session_token! if current_user
    session[:sessions_token] = nil
  end



end
