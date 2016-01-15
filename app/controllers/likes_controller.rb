class LikesController < ApplicationController
  def like_toggle
    @like = Like.find_by_id(params[:id])
    @like.is_like = !@like.is_like
    if(@like.likeable_type=="Note")
      @note = Note.find_by_id(@like.likeable_id)
      if @note.likenum ==nil
        @note.likenum = 0
      end
      if(@like.is_like==true)
        @note.likenum += 1
      else
        @note.likenum -= 1
      end
      @note.save
    end
=begin    
    if @like.likeable_type == "Section"
      @num = Section.find_by_id(@like.likeable_id).likes.where().count
    else
      @num = Note.find_by_id(@like.likeable_id).likes.count
    end
=end
    
    @like.save
    respond_to do |format|
      #format.html {redirect_to  }
      format.json{render json: @like.is_like} #create.js
    end
  end
  def bookmark_toggle
    @like = Like.find_by_id(params[:id])
    @like.is_bookmark = !@like.is_bookmark
    @like.save
    respond_to do |format|
      #format.html {redirect_to  }
      format.json{render json: @like.is_bookmark}
    end
  end
end
