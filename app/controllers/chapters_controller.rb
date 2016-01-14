class ChaptersController < ApplicationController
  layout "note_layout"
  def create
    
    @note = Note.find(params[:note_id])

    @chapters = @note.chapters
    @chapter = @note.chapters.new
    @chapter.title = '新章節'
    @chapter.index = @chapters.count
    @chapter.save

    #@chapter.save
    respond_to do |format|
      #format.html {redirect_to  }
      format.js #create.js
    end
  end

  def show
  end

  def update
    puts params
    @chapter = Chapter.find(params[:id])
    respond_to do |format|
        if @chapter.update_attributes(chapter_params) 
          format.html { redirect_to(@chapter) }
          format.json { respond_with_bip(@chapter) }
        else
          format.html { render :action => "edit" }
          format.json { respond_with_bip(@chapter) }
        end
      end    
  end

  def destroy
  end

  def reloadIndex
    params[]
  end
  def swap
     #params[:id1]
  end

  def paste_section(chapter_id)
    @chapter = Chapter.find_by_id(chapter_id)
    @section = Section.find_by_id(session[:section_id])
    @chapter.sections << @section
    @section.chapters << @chapter
    session[:section_id] = nil
  end

  def chapter_params
    params.require(:chapter).permit(:title,:index)
  end
end
