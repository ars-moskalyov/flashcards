class AddDefaultDeckToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :default_deck, :integer
  end
end
