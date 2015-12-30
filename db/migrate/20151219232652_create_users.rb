class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.timestamps null: false
      
      t.datetime :remember_created_at
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      t.string   :link 
      t.string   :gender
      t.string   :image
      t.string   :email
      t.string   :uid
      t.string   :name
      t.string    :oauth_token
      t.string    :provider
      
    end
  end
end
