class Tag < ActiveRecord::Base
  has_and_belongs_to_many :sections 
  def self.get_text
    self.connection.select_all("select text from tags")
  end  
end
