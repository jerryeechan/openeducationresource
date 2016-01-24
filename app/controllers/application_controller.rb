require 'oauth'

class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery

  HACKPAD_SERVER = URI.parse(ENV['HACKPAD_SERVER'])
  HACKPAD_CLIENT_ID = ENV['HACKPAD_CLIENT_ID']
  HACKPAD_SECRET = ENV['HACKPAD_SECRET']

  def hackpad
    @hackpad ||= OAuth::Consumer.new HACKPAD_CLIENT_ID, HACKPAD_SECRET, {
      :site => HACKPAD_SERVER
    }
  	return @hackpad
  end
  
  def current_user
    puts "current_user called"
    puts session[:user_id]
    puts User.find_by(uid: session[:user_id])
    @current_user ||= User.find_by(uid: session[:user_id]) if session[:user_id]
    return @current_user
  end
  helper_method :current_user

  def anonymous_user
    @anonymous_user = User.anonymous
  end
  helper_method :anonymous_user

  
  def create_hackpad(user_email,title)
    
      puts "/api/1.0/pad/create?asUser=#{user_email}" 
      res = hackpad.request :post, "/api/1.0/pad/create?asUser=#{user_email}", nil, {}, title, { 'Content-Type' => 'text/plain' }
      if res.is_a? Net::HTTPSuccess
        json = ActiveSupport::JSON.decode res.body
        return json['padId']
      else
        return nil
      end
  end

end
