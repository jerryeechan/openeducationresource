class CreatePads < ActiveRecord::Migration
  def change
    create_table :pads do |t|

      t.timestamps null: false
      t.string :url 
    end
  end
end
