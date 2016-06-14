class AddUsernameAndBirthdayToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :username, :string
    add_index :users, :username, unique: true
    add_column :users, :birthday, :date
    add_column :users, :gender, :string
  end
end
