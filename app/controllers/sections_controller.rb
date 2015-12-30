class SectionsController < ApplicationController
  include ActionView::Helpers::TextHelper
  layout "note_layout"
  respond_to :html, :js
  def show

    @section = Section.find(params[:id])

    #@user_email = current_user.email
    @user_email = 
    res = hackpad.request :get, "/api/1.0/pad/#{@section.padId}/content.txt?asUser=#{@user_email}"

    if res.is_a? Net::HTTPSuccess
      @content = res.body
      puts @content
    else
      puts res
      puts res.body
    end   
    
    
    opts = {
      :padId => @section.padId,
      #:email => 'anonymous@hackpad.user',
      :email => current_user.email,
      :name => current_user.name
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
    @chapter = Chapter.find(params[:chapter_id])
  end

  def create
    puts "create section"
    @chapter = Chapter.find(params[:chapter_id])
    if params[:mode] == 'url'
      @url_split = params[:pad_url].split('--')
      params[:section][:padId] = @url_split[1]

    
      puts params[:section][:padId]
      @section = @chapter.sections.create(section_param)
      @section.index = Section.find(:chapter_id=>params[:chapter_id]).length+1

      redirect_to @section
    else # mode == new
      @user_email = current_user.email
      puts @user_email
      @user_email = 'pupu1416@yahoo.com.tw'
      puts @user_email
      puts "/api/1.0/pad/create?asUser=#{@user_email}"
      puts params[:section][:title]
      res = hackpad.request :post, "/api/1.0/pad/create?asUser=#{@user_email}", nil, {}, params[:section][:title], { 'Content-Type' => 'text/plain' }

      if res.is_a? Net::HTTPSuccess
        json = ActiveSupport::JSON.decode res.body
        params[:section][:padId] = json['padId']
        @section = @chapter.sections.create(section_param)
        redirect_to @section
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
    Section.find(params[:id]).destroy
    redirect_to current_note
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
