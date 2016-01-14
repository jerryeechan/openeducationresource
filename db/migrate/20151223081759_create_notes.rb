class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.timestamps null: false
      t.string :title
      t.integer :viewby
      t.integer :follower
      t.string :description_padId
#      t.string :description_padId
    end
  end
end
