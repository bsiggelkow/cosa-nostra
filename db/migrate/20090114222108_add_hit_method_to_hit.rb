class AddHitMethodToHit < ActiveRecord::Migration
  
  def self.up
    add_column :hits, :hit_method_id, :integer
  end

  def self.down
    remove_column :hits, :hit_method_id
  end
  
end
