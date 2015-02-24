class Card < ActiveRecord::Base
  has_many :card_ownerships
  has_many :game_players, through: :card_ownerships
  has_many :games, through: :card_ownerships
  validates :value,
    presence: true
end
