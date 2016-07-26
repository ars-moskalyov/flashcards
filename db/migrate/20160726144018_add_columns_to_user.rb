class AddColumnsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :subscribe, :boolean, default: true, null: false
    add_column :users, :name, :string
  end
end
