class LikesController < ApplicationController
  def like_toggle
    @like = Like.find_by_id(params[:id])
    @like.is_like = !@like.is_like 
    puts @like.is_like
    puts "Like Toggle"
    @like.save
    respond_to do |format|
      #format.html {redirect_to  }
      format.json{render json: true} #create.js
    end
  end
  def bookmark_toggle
    @like = Like.find_by_id(params[:id])
    @like.is_bookmark = !@like.is_bookmark
    @like.save
    respond_to do |format|
      #format.html {redirect_to  }
      format.json{render json: true}
    end
  end
end
