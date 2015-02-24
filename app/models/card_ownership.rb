class CardOwnership < ActiveRecord::Base
  belongs_to :card
  belongs_to :game_player
  belongs_to :game

  validates :card,
    uniqueness: {scope: :game_id},
    presence: true

  validates :game_player,
    presence: true

  validates :game,
    presence: true
end
