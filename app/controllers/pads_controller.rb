require 'net/http'

class PadsController < ApplicationController
  respond_to :html


  # GET /pads/1
  def show
    req = hackpad.request :post, "/api/1.0/user/create?email=test@ee.com.tw&name=nono"
    puts(req)
    @pad_id = params[:id]

=begin    
    res = hackpad.request :get, "/api/1.0/pad/#{@pad_id}/content.txt"

    if res.is_a? Net::HTTPSuccess
      respond_with @content = res.body
    else
      logger.warn "#{res.inspect}: #{res.body}"
      head :bad_request
    end   
=end

    puts 'Pad_id:'

    puts params[:id]
    opts = {
      :padId => params[:id],
      #:email => 'anonymous@hackpad.user',
      :email => 'pupu1416@yahoo.com.tw',
      :name => 'pupu11'
    }
    req = hackpad.create_signed_request :get, "/ep/api/embed-pad?#{opts.to_query}", nil, { :scheme => :query_string }
    respond_with @pad_url = hackpad.uri + req.path
  end


  # GET /pads/new
  def new
  end

  # POST /pads
  def create
    

    content = params[:content]
    @user = 'test@yahoo.com.tw|hackpad'
    res = hackpad.request :post, "/api/1.0/pad/create?asUser=#{@user}", nil, {}, content, { 'Content-Type' => 'text/plain' }

    if res.is_a? Net::HTTPSuccess
      json = ActiveSupport::JSON.decode res.body
      redirect_to pad_path json['padId']
    else
      logger.warn "#{res.inspect}: #{res.body}"
      head :bad_request
    end
  end

  # GET /pads/1/edit
  def edit
    @pad_id = params[:id]

    res = hackpad.request :get, "/api/1.0/pad/#{@pad_id}/content/latest.txt"

    if res.is_a? Net::HTTPSuccess
      respond_with @content = res.body
    else
      logger.warn "#{res.inspect}: #{res.body}"
      head :bad_request
    end    
  end

  # POST /pads/1
  def update
    @pad_id = params[:id]
    content = params[:content]

    res = hackpad.request :post, "/api/1.0/pad/#{@pad_id}/content", nil, {}, content, { 'Content-Type' => 'text/plain' }

    if res.is_a? Net::HTTPSuccess
      redirect_to pad_path @pad_id
    else
      logger.warn "#{res.inspect}: #{res.body}"
      head :bad_request
    end
  end

  # GET /pads
  def index
    puts hackpad
    
    res = hackpad.request :get, "/api/1.0/pads/all"

    if res.is_a? Net::HTTPSuccess

      @pads = ActiveSupport::JSON.decode(res.body)
      puts @pads 

      #redirect_to pad_path @pad_id
    else
      logger.warn "#{res.inspect}: #{res.body}"
      head :bad_request
    end
  end
end
