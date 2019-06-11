class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :auth_token

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def login(user)
    session[:session_token] = user.reset_session_token!
    @current_user = user
  end

  def logout
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def logged_in?
    !!current_user
  end

  def require_login
    redirect_to new_session_url unless logged_in?
  end

  def auth_token
    html = " <input type=\"hidden\"  "
    html += " name=\"authenticity_token\"   "
    html += " value=\"#{form_authenticity_token}\" >  "
    html.html_safe
  end

end
