class AddRoles < ActiveRecord::Migration
  
  def self.up
    Role.create(:name => "Boss")
    Role.create(:name => "Wise Guy")
  end

  def self.down
    Role.destroy_all
  end
  
end
