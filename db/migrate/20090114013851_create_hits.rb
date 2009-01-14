class CreateHits < ActiveRecord::Migration
  
  def self.up
    create_table :hits do |t|
      t.integer :assigned_to
      t.integer :target
      t.string :state  
      t.timestamps
    end
  end

  def self.down
    drop_table :hits
  end
  
end
