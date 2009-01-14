class CreatePermissions < ActiveRecord::Migration
  def self.up
    create_table :permissions do |t|
      t.belongs_to :role
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :permissions
  end
end
