class CreateSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|
      t.references :leader
      t.references :follower

      t.timestamps
    end
  end
end
