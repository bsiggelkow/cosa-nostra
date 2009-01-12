class CreateUsers < ActiveRecord::Migration
  
  def self.up
    create_table(:users) do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :crypted_password, :limit => 40
      t.string :salt, :limit => 40
      t.string :remember_token
      t.datetime :remember_token_expires_at
      t.boolean :confirmed, :default => false, :null => false
      t.string :confirmation_code
      t.string :reset_password_code
    end
    add_index :users, :email
    add_index :users, :remember_token
  end

  def self.down
    drop_table(:users)
  end
  
end
