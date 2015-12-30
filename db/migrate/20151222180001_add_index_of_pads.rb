class AddIndexOfPads < ActiveRecord::Migration
  def change
    #add_reference :sections, :chapters, index: true
    add_reference :questions, :section, index: true
    add_reference :chapters, :note, index: true
  end
end
