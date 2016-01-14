class TagsController < ApplicationController
  def create
    json = JSON.parse(request.body.read)
    
    
    #ajax 
    @tag = Tag.where(:text=>json["text"]).first_or_create
    respond_to do |format|
      #format.html {redirect_to  }
      format.js #create.js
    end
  end
  def getAll
    @tags = Tag.all
    respond_to do |format|
      #format.html {redirect_to  }
      format.json  { render json: @tags }#create.js
    end
  end
end
