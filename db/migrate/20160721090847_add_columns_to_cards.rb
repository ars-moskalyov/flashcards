class AddColumnsToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :check, :integer, default: 1, null: false
    add_column :cards, :effort, :integer, default: 0, null: false

    Card.all.update_all(check: 1, effort: 0)
  end
end
