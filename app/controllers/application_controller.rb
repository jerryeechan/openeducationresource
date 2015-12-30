require 'oauth'

class ApplicationController < ActionController::Base
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

=begin
  def current_user
    @current_user ||= User.find_by(uid: session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
  def current_note
    @note = Note.find_by_id(session[:note_id])
  end
  helper_method :current_note

  def destroy_current_note
    session[:note_id] = nil
  end


  helper_method :destroy_current_note

  def get_all_notes
    @notes = Note.all
  end

  helper_method :get_all_notes

  def get_note_created_user(user_id)
    @user = User.find(user_id)
  end

  helper_method :get_note_created_user
=end
  

end
