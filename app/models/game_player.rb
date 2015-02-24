class GamePlayer < ActiveRecord::Base
  belongs_to :game
  belongs_to :user
  has_many :card_ownerships
  has_many :cards, through: :card_ownerships

  validates_presence_of :game
  validates_presence_of :user
end
