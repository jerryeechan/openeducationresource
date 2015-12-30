class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|

      t.timestamps null: false
      t.string :title
      t.integer :index
    end
  end
end
