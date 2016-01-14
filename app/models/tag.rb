class Tag < ActiveRecord::Base
  def self.get_text
    self.connection.select_all("select text from tags")
  end  
end
