class Section < ActiveRecord::Base
  default_scope { order(:index) }
  #has_and_belongs_to_many :chapters
  belongs_to :chapter
  has_many :likes,:as=>:likeable,:dependent => :delete_all
  has_and_belongs_to_many :tags 
end
