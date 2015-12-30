class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.timestamps null: false
      t.string :padId
      t.string :title
      t.integer :index
    end
  end
end
