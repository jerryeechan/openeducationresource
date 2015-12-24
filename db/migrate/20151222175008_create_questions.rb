class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|

      t.timestamps null: false
      t.string :padId
    end
  end
end
