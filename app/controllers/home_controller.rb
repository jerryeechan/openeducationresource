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
    keyword = params[:search]
    
    #@users = User.where("name like #{keyword}")
    
    @notes = Note.where("title like ?","#{keyword}%")
    @chapters = Chapter.where("title like ?","#{keyword}%")
    @sections = Section.where("title like ?","#{keyword}%")
  end
  def favorite
    puts current_user.likes
    puts current_user.likes.count
    puts current_user.likes.where(:is_bookmark=>true)
    @likes = current_user.likes.where(:is_bookmark=>true)
  end
end
