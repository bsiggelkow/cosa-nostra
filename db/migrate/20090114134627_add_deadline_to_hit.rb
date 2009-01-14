class AddDeadlineToHit < ActiveRecord::Migration
  
  def self.up
    add_column :hits, :deadline, :datetime
  end

  def self.down
    remove_column :hits, :deadline
  end
  
end
