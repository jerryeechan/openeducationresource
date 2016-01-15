class SectionTags < ActiveRecord::Migration
  def change

    create_table :sections_tags, :id => false do |t|
      t.integer :tag_id
      t.integer :section_id
    end
  end
end
