class Like < ActiveRecord::Base
    belongs_to :likeable,:polymorphic=>true  # foreign key - section_id
    belongs_to :user     # foreign key - user_id
=begin
    after_initialize :init

    def init
      self.is_like = false if self.is_like.nil?            #will set the default value only if it's nil
      self.is_bookmark = false if self.is_bookmark.nil? #let's you set a default association
    end
=end

end
