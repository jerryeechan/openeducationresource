class AddIndexOfPads < ActiveRecord::Migration
  def change
    add_reference :sections, :chapter, index: true
    add_reference :questions, :section, index: true
    add_reference :chapters, :note, index: true
    
    

    create_table :users_sections_likes, :id => false do |t|
      t.integer :user_id
      t.integer :section_id
    end
  end
end
