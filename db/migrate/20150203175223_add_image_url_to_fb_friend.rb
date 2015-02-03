class AddImageUrlToFbFriend < ActiveRecord::Migration
  def change
    add_column :fb_friends, :image_url, :text
  end
end
