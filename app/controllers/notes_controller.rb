class NotesController < ApplicationController
  layout "note_layout", :only => :show
  def index
    @notes = Note.all
  end
  def show
    destroy_current_section
    @note = Note.find(params[:id])
    session[:note_id] = params[:id]
  end

  def new
    @note = Note.new
  end

  def create
    @note = current_user.notes.create(note_params)
    

    @user_email = "pupu1416@yahoo.com.tw"
    @title = note_params[:title]
    @pad_id = create_hackpad(@user_email,@title+"簡介\n在這裡加上關於本課程的介紹")
    @note.description_padId = @pad_id
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

    json = request.body.read
    puts json
    
    chapter_array = JSON.parse(json)["json"]
    
    puts "parasm~~~~"
    
    puts chapter_array
    puts "parasm~~~~end"
    
    puts chapter_array

    ci = 0
    chapter_array.each do |chapter_jobj|

      chapter_id = chapter_jobj["chapter"].to_i

      chapter =  Chapter.find(chapter_id)
      chapter.index = ci
      chapter.save
      section_ids = chapter_jobj["sections"]

      (0...section_ids.count).each do |i|

        section = Section.find(section_ids[i].to_i)

        section.index = i
        section.chapter_id = chapter_id

        puts section.id
        puts section.title
        puts section.index
        
        

        section.save
      end
      ci = ci+1
    end
    respond_to do |format|
      #format.html {redirect_to  }
      format.js #create.js
    end
  end
  def note_params
    params.require(:note).permit(:title)
  end
  

end
