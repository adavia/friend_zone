class ChangeDataTypeForBodyComment < ActiveRecord::Migration[5.0]
  def change
    change_column :comments, :body, :string
  end
end
