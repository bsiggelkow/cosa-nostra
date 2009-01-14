class CreateUserStatuses < ActiveRecord::Migration
  def self.up
    create_table :user_statuses do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :user_statuses
  end
end
