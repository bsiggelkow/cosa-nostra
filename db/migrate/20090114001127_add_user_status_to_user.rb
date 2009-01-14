class AddUserStatusToUser < ActiveRecord::Migration
  
  def self.up
    add_column :users, :user_status_id, :integer
  end

  def self.down
    remove_column :users, :user_status_id
  end
end
