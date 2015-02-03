class CreateFbFriends < ActiveRecord::Migration
  def change
    create_table :fb_friends do |t|
      t.string :profile_id
      t.string :profile_url
      t.string :username
      t.string :first_name
      t.string :last_name
      t.string :name
      t.string :email
      t.string :gender
      t.string :location
      t.string :hometown
      t.date :birthday
      t.integer :user_id

      t.timestamps
    end
  end
end
