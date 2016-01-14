class LikesController < ApplicationController
  def like_toggle
    #section id??
    params[:id]
    
    @like = Like.where(:user_id=>params[:user_id],:section_id=>params[:id])
    @like.islike = !@like.islike 
    @like.save
    
  end
  def bookmark_toggle
    @like = Like.where(:user_id=>params[:user_id],:section_id=>params[:id])
    @like.isbookmark = !@like.isbookmark
    @like.save
  end
end
