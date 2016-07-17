class RenameColumnInUsers < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :default_deck, :default_deck_id
  end
end
