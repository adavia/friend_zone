class ChangeMessagesColumn < ActiveRecord::Migration[5.0]
  def up
    remove_column :messages, :read
    add_column :messages, :read_at, :datetime
  end

  def down
    remove_column :messages, :read
    add_column :messages, :read_at, :boolean
  end
end
