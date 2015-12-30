class QuestionsController < ApplicationController
  def new
    @section = Section.find(:section_id)
    
  end
end
