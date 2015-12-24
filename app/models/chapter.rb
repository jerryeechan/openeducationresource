class Chapter < ActiveRecord::Base
  has_many :sections
  belongs_to :note
end
