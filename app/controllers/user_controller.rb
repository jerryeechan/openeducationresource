class UserController < ApplicationController
  def index
    @user = anonymous_user
    puts @user.name
  end
end
