class Game < ActiveRecord::Base
  has_many :game_players, dependent: :destroy
  has_many :card_ownerships, dependent: :destroy
  def deal(num, player)
    puts num
    unless num <= 0
      deck = find_unowned_cards
      card = deck.shuffle.first
      CardOwnership.create(game: self, game_player: player, card: card)
      deal(num - 1, player)
    end
  end

  def is_owned_in_game(card)
    if CardOwnership.find_by_game_id_and_card_id(self.id, card.id).nil?
      return false
    end
    true
  end

  def find_unowned_cards
    cards = []
    Card.all.each do |card|
      unless is_owned_in_game(card)
        cards << card
      end
    end
    cards
  end

  def can_play?(card)
    last = Card.find(last_played_id)
    if card.color == last.color || card.value == last.value || card.value.include?("Wild")
      return true
    end
    false
  end
end
