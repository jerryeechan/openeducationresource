class NotesController < ApplicationController
  def index
    @notes = Note.all
  end
  def show
    @note = Note.find(params[:id])
  end

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
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

  def note_params
    params.require(:note).permit(:title)
  end
end
