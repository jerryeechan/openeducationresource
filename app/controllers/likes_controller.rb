class LikesController < ApplicationController
  def like_toggle
    @like = Like.find_by_id(params[:id])
    @like.is_like = !@like.is_like

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
