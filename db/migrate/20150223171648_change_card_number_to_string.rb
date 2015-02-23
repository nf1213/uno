class ChangeCardNumberToString < ActiveRecord::Migration
  def change
    remove_column :cards, :number, :integer
    add_column :cards, :value, :string
  end
end
