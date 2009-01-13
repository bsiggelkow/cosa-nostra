class AddUserToFamily < ActiveRecord::Migration
  
  def self.up
    add_column :users, :family_id, :integer
  end

  def self.down
    remove_column :users, :family_id
  end
  
end
