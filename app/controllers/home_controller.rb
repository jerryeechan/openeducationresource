class HomeController < ApplicationController
  layout "application"
  def index
    @notes = Note.all
    @user = User.all
  end

  def search
    #todo
=begin
  search for the notes with title, tag, chapter title or sections
  give priority
=end
    @notes = Note.search_keyword_user(params[:search])
  end
end
