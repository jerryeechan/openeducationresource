class TagsController < ApplicationController
  def create
    puts params
    puts params[:text]
    #ajax 
    @tag = Tag.where(:text=>params[:text]).first_or_create
    respond_to do |format|
      #format.html {redirect_to  }
      format.js #create.js
    end
  end
  def get
    @tags = Tag.all.pluck(:text)
    respond_to do |format|
      #format.html {redirect_to  }
      format.json  { render json: @tags }#create.js
    end
  end
end
