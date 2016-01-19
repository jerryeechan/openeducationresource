class SessionsController < ApplicationController
  def login
    session[:return_path] = request.referer
    puts session[:return_path]
    
    redirect_to fb_login_path
  end

  def create
    @user = User.from_omniauth(env["omniauth.auth"])
    #??
    if @user.nil?
      redirect_to user_close_path
    else
      session[:user_id] = @user.uid

    redirect_to session.delete(:return_path)
  end
  end

  def destroy
    session[:user_id] = nil 
    redirect_to request.referer
  end
end