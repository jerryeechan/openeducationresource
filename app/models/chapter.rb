class Chapter < ActiveRecord::Base
  #has_many :sections
  has_and_belongs_to_many :sections
  belongs_to :note
end
