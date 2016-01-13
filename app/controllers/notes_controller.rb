class NotesController < ApplicationController
  layout "note_layout", :only => :show
  def index
    @notes = Note.all
  end
  def show
    @note = Note.find(params[:id])
    session[:note_id] = params[:id]
  end

  def new
    @note = Note.new
  end

  def create
    @note = current_user.notes.create(note_params)
    
    #current_user.notes << @note
    #current_user.save
    if @note.save
      redirect_to @note
    end
  end

  def update
    @note = Note.find(params[:id])
    respond_to do |format|
        if @note.update_attributes(note_params) 
          format.html { redirect_to(@note) }
          format.json { respond_with_bip(@note) }
        else
          format.html { render :action => "edit" }
          format.json { respond_with_bip(@note) }
        end
      end
  end
  def reorder
    puts params
    chapter_array = params[:json]
    chapter_array.each do |chapter_jobj|
      chapter_id = chapter_jobj[:chapter_id]
      section_ids = chapter_jobj[:section_id]

      (0...section_ids.count-1).each do |i|
        section = Section.find(section_ids[i])
        section.index = i
        section.chapter_id = chapter_id
      end
    end
  end
  def note_params
    params.require(:note).permit(:title)
  end
  

end
