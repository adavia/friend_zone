class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.integer :recipient_id
      t.integer :sender_id
      t.datetime :read_at
      t.string :action
      t.references :notifiable, polymorphic: true

      t.timestamps
    end
  end
end
