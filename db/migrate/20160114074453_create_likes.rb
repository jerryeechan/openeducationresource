class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.timestamps null: false
      t.string :text
    end
  end
end
