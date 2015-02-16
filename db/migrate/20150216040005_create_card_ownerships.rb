class CreateCardOwnerships < ActiveRecord::Migration
  def change
    create_table :card_ownerships do |t|
      t.integer :user_id, null: false
      t.integer :card_id, null: false
      t.integer :game_id, null: false

      t.timestamps null: false
    end
    add_index :card_ownerships, [:card_id, :game_id], unique: true
  end
end
