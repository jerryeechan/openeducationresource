class Section < ActiveRecord::Base
  default_scope { order(:index) }
  #has_and_belongs_to_many :chapters
  belongs_to :chapter
  has_many :questions
  has_many :likes,:as=>:likeable
  has_and_belongs_to_many :tags 
end
