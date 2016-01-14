class Like < ActiveRecord::Base
    belongs_to :section  # foreign key - programmer_id
    belongs_to :user     # foreign key - project_id
end
