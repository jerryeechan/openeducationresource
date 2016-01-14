class Section < ActiveRecord::Base
  default_scope { order(:index) }
  #has_and_belongs_to_many :chapters
  belongs_to :chapter
  has_many :questions
  has_many :liked_from_users, foreign_key: "liked_section_id", class_name: "User"
  has_many :tags
  has_many :users, through: :tags

end
