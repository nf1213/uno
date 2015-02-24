class ChangeUserToPlayerInCardOwnerships < ActiveRecord::Migration
  def change
    remove_column :card_ownerships, :user_id, :integer
    add_column :card_ownerships, :game_player_id, :integer, null: false
  end
end
