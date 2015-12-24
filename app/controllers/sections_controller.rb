class SectionsController < ApplicationController
  def show
    @section = Section.find(params[:id])
    
    opts = {
      :padId => @section.padId,
      #:email => 'anonymous@hackpad.user',
      :email => 'anonymous@hackpad.user',
      :name => '匿名用戶'
    }
    req = hackpad.create_signed_request :get, "/ep/api/embed-pad?#{opts.to_query}", nil, { :scheme => :query_string }
    respond_with @pad_url = hackpad.uri + req.path
  end
  def new
    #content = params[:content]

    @user_email = 'test@yahoo.com.tw|hackpad'
    res = hackpad.request :post, "/api/1.0/pad/create?asUser=#{@user_email}", nil, {}, '', { 'Content-Type' => 'text/plain' }

    if res.is_a? Net::HTTPSuccess
      json = ActiveSupport::JSON.decode res.body
      
      params[:section][:padId] = json['padId']
      @chapter = Chapter.find(params[:chapter_id])
      @chapter.sections.create(section_param)
      redirect_to pad_path json['padId']
    else
      logger.warn "#{res.inspect}: #{res.body}"
      head :bad_request
    end

    ## not done
  end

  def create
    @note = Note.find(params[:id])
    @note.sections.create(section_param)

    ## not done
  end

  def clone
    @section = Section.find(params[:id])
    @new_section = @section.dup
    @note =  Note.find(params[:note_id])
    ## not done
  end

  def section_param
    params.require(:section).permit(:padId)
  end
end
