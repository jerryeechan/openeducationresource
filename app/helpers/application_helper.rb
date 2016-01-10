module ApplicationHelper
  
  def current_note
    @note = Note.find_by_id(session[:note_id])
  end
  

  def destroy_current_note
    session[:note_id] = nil
  end


  

  def get_all_notes
    @notes = Note.all
  end

  

  def get_note_created_user(user_id)
    @user = User.find(user_id)
  end

end
