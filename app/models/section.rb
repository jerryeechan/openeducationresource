class Section < ActiveRecord::Base
  has_and_belongs_to_many :chapters
  #belongs_to :chapter
  has_many :questions
end
