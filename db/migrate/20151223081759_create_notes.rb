class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|

      t.timestamps null: false
      t.string :title
#      t.string :description_padId
    end
  end
end
