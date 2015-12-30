class Note < ActiveRecord::Base
  has_many :chapters
  has_many :sections, through: :chapters
  belongs_to :user
end
