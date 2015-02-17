class AddEmailAndPasswordFieldsToCatModel < ActiveRecord::Migration
  def change
  	add_column :cats, :email, :string, uniqueness: true
  	add_column :cats, :password_digest, :string

  	add_index :cats, :email, unique: true
  end
end
