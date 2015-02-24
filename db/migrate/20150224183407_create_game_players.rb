class CreateGamePlayers < ActiveRecord::Migration
  def change
    create_table :game_players do |t|
      t.integer :user_id, null: false
      t.integer :game_id, null: false
    end
  end
end
