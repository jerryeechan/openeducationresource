class ChaptersController < ApplicationController
  def create
    puts params
    @note = Note.find(params[:note_id])
    @chapters = @note.chapters
    @chapter = @note.chapters.new
    @chapter.title = '新章節'
    @chapter.index = @chapters.count+1
    @chapter.save
    #@chapter.save
    respond_to do |format|
      #format.html {redirect_to  }
      format.js #create.js
    end
  end
end
