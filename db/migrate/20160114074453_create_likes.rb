class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.timestamps null: false
      t.integer :user_id,  index: true
      t.belongs_to :likeable, :polymorphic=>true, index: true
      t.boolean :is_like,default: false
      t.boolean :is_bookmark,default: false
    end
  end
end
