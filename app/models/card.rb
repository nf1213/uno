class Card < ActiveRecord::Base
  has_many :card_ownerships
  has_many :game_players, through: :card_ownerships
  has_many :games, through: :card_ownerships
  
  validates_presence_of :value

  def self.colors
    ['red', 'green', 'blue', 'yellow']
  end

  def is_wild?
    if value.include?("Wild")
      return true
    end
    false
  end
end
