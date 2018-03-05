class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

#  include SessionsHelper
# end


  def log_in(user)
    session[:user_id] = user.id
    current_user
    user.remember
  end

  def current_user=(user)
    user && user.authenticated?(cookies[:remember_token]) ? user : nil
  end

  def current_user
    current_user ||= current_user=(User.find_by(id: session[:user_id]))
    return current_user
  end

  def remember_session(user)
      #user.remember
      cookies.permanent.signed[:user_id] = user.id
      cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
      user.forget
      cookies.delete(:user_id)
      cookies.delete(:remember_token)
  end

  def logged_in?
      !current_user.nil?
  end

  def log_out
      forget(current_user)
      session.delete(:user_id)
      @current_user = nil
  end
end
