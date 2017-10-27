class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :owns_cat?

  def login!(user)
    session[:sessions_token] = user.sessions_token
  end

  def logout!
    current_user.reset_session_token!
    session[:sessions_token] = nil
  end

  def current_user
    return nil unless sessions[:sessions_token]
    @current_user ||= User.find_by(sessions_token: session[:sessions_token])
  end

  def require_logged_in

  end

  def require_logged_out
    if logged_in?
      redirect_to cats_url
    end
  end

  private

  def logged_in?
    !!current_user
  end

  protected

  def login_user!
    user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )
    if user.nil?
      flash.now[:errors] = ["Invalid username or password"]
      render :new
    else
      login!(user)
      redirect_to cats_url
    end
  end

  def owns_cat?
    current_user.cats.include?(Cat.find(params[:id]))
  end
end
