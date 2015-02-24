class AddLastPlayedIdToGame < ActiveRecord::Migration
  def change
    add_column :games, :last_played_id, :integer
  end
end
