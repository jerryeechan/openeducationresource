class SectionsController < ApplicationController
  include ActionView::Helpers::TextHelper
  layout "note_layout"
  def show
    @note = Note.find(params[:note_id])
    @chapter = Chapter.find(params[:chapter_id])
    @section = Section.find(params[:id])
    
    if current_user
      @user_email = @current_user.email
    else
      @user_email = anonymous_user.email
    end


    #@user_email = 
    res = hackpad.request :get, "/api/1.0/pad/#{@section.padId}/content.txt?asUser=#{@user_email}"
    if res.is_a? Net::HTTPSuccess
      @content = res.body
      puts @content
    else
      puts res
      puts res.body
    end   
    
    @user_email = 'test123@hackpad.com'
    session[:chapter_id] = params[:chapter_id]
    session[:section_id] = params[:id]
    session[:note_id] = params[:note_id]
    opts = {
      :padId => @section.padId,
      #:email => 'anonymous@hackpad.user',
      :email => @user_email,
      :name => 'tester' #@current_user.name
    }
    
    @pad_url = hackpad.uri + get_pad_url(opts)

  end

  def get_pad_url(opts)
    req = hackpad.create_signed_request :get, "/ep/api/embed-pad?#{opts.to_query}", nil, { :scheme => :query_string }
    @path = req.path
  end

  def new
    destroy_current_section
    @note = Note.find(params[:note_id])
    @chapter = Chapter.find(params[:chapter_id])
  end

  def create
    puts "create section"
    
    @chapter = Chapter.find(params[:chapter_id])
    @note = Note.find(@chapter.note_id)
    if params[:mode] == 'url'
      @url_split = params[:pad_url].split('-')
      params[:section][:padId] = @url_split[@url_split.count-1]

    
      puts params[:section][:padId]
      @section = @chapter.sections.create(section_params)

      @section.index = @chapter.sections.length
      @section.save

      respond_to do |format|
        #format.html {redirect_to  }
          format.js #create.js
      end
    else # mode == new
      #@user_email = current_user.email
      @user_email = "pupu1416@yahoo.com.tw"
      puts "/api/1.0/pad/create?asUser=#{@user_email}"
      puts params[:section][:title]
      res = hackpad.request :post, "/api/1.0/pad/create?asUser=#{@user_email}", nil, {}, params[:section][:title], { 'Content-Type' => 'text/plain' }
      if res.is_a? Net::HTTPSuccess
        json = ActiveSupport::JSON.decode res.body
        params[:section][:padId] = json['padId']
        @section = @chapter.sections.create(section_params)
        #redirect_to @section
        respond_to do |format|
        #format.html {redirect_to  }
          format.js #create.js
        end
      else
        logger.warn "#{res.inspect}: #{res.body}"
        head :bad_request
      end
    end
  end
  def createqa
    @section = Section.find_by_id(params[:id])
    if @section.qa_pad_id == nil
      @section.qa_pad_id= create_hackpad("pupu1416@yahoo.com.tw","#{@section.title} Q&A")
      @section.save
    end
    
    respond_to do |format|
      format.js #create.js
    end
  end
  def update
    @section =Section.find(params[:id])

    respond_to do |format|
        if @section.update_attributes(section_params) 
          format.html { redirect_to(@section) }
          format.json { respond_with_bip(@section) }
        else
          format.html { render :action => "edit" }
          format.json { respond_with_bip(@section) }
        end
    end

  end

  def destroy
    #destroy_current_section
    @section = Section.find(params[:id])
    @chapter = find_chapter(@section)
    @note = find_note(@chapter)
    @section.likes.destroy
    @section.destroy
    

    if session[:section_id]==params[:id]
      #redirect to note
      render :js => "window.location = '#{note_path(@note)}'"
    else
      #ajax delete
      redirect_to @note,status: 303
    end
  end
  def copy
    session[:section_id] = params[:id]
  end

  def reloadIndex
    
  end

  def section_params
    params.require(:section).permit(:title,:padId)
  end
end
