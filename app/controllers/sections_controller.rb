class SectionsController < ApplicationController
  include ActionView::Helpers::TextHelper
  layout "note_layout"
  respond_to :html, :js
  def show
    @note = Note.find(params[:note_id])
    @chapter = Chapter.find(params[:chapter_id])
    @section = Section.find(params[:id])
    @section_like = @section.likes.where(:likeable_id=>params[:id],:likeable_type=>"Section",:user_id=>current_user.id).first_or_create
    @note_like = @note.likes.where(:likeable_id=>params[:id],:likeable_type=>"Note",:user_id=>current_user.id).first_or_create
    if current_user
      @user_email = @current_user.email
    else
      @user_email = anonymous_user.email
    end

=begin    
    #@user_email = 
    res = hackpad.request :get, "/api/1.0/pad/#{@section.padId}/content.txt?asUser=#{@user_email}"
    if res.is_a? Net::HTTPSuccess
      @content = res.body
      puts @content
    else
      puts res
      puts res.body
    end   
    
=end
    session[:section_id] = params[:id]
    opts = {
      :padId => @section.padId,
      #:email => 'anonymous@hackpad.user',
      :email => @user_email,
      :name => 'tester' #@current_user.name
    }
    
    @pad_url = hackpad.uri + get_pad_url(opts)

    @section.questions.each do |question|
      opts[:padId] = question.padId
      question.pad_url = get_pad_url(opts)
    end
    #@questions = section.questions
  end

  def get_pad_url(opts)
    req = hackpad.create_signed_request :get, "/ep/api/embed-pad?#{opts.to_query}", nil, { :scheme => :query_string }
    @path = req.path
  end

  def new
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
      @section = @chapter.sections.create(section_param)

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
        @section = @chapter.sections.create(section_param)
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

  def update
    Section.find()
  end

  def destroy
    @note = Note.find(params[:chapter_id])
    Section.find(params[:id]).destroy
    redirect_to @note
  end
  def copy
    session[:section_id] = params[:id]
  end

  def reloadIndex
    
  end

  def section_param
    params.require(:section).permit(:title,:padId)
  end
end
