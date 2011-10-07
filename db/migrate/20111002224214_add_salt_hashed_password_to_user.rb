class AddSaltHashedPasswordToUser < ActiveRecord::Migration
  def change
    add_column :users, :salt, :string
    add_column :users, :hashed_password, :string
  end
end
