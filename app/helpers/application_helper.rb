module ApplicationHelper
  
  def current_note
    @note = Note.find_by_id(session[:note_id])
  end
  
  def current_section
    @section = Section.find_by_id(session[:section_id])
  end

  def destroy_current_section
    session[:section_id] = nil
  end

  def destroy_current_note
    session[:note_id] = nil
    session[:section_id] = nil
  end

  def get_section_like
    @section = current_section
    @user = current_user
    puts "werawer"
    puts @section.likes
    puts @section.likes.count
    puts "werawer"
    @section_like = Like.where(:likeable_id=>@section.id,:likeable_type=>"Section",:user_id=>@user.id).first_or_create
  end
  def get_section_like_num
    @section = current_section
    @section_like_num = @section.likes.where(:is_like=>true).count
  end
  def get_note_like
    @note = current_note
    @user = current_user
    @note_like = Like.where(:likeable_id=>@note.id,:likeable_type=>"Note",:user_id=>@user.id).first_or_create
  end
  def get_note_like_num
    @note = current_note
    @note_like_num = @note.likes.where(:is_like=>true).count    
  end

  def get_tags
    @tags = Tag.all
  end
  

  def get_all_notes
    @notes = Note.all
  end

  

  def get_note_created_user(user_id)
    @user = User.find(user_id)
  end

end
