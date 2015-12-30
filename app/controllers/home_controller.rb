class HomeController < ApplicationController
  layout "application"
  def index
    @notes = Note.all
    @user = User.all
  end
end
