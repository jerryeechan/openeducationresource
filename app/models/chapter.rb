class Chapter < ActiveRecord::Base
  has_many :sections
  default_scope { order(:index) }
  #has_and_belongs_to_many :sections
  belongs_to :note
end
