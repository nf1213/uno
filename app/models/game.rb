class Game < ActiveRecord::Base
  belongs_to :player1, class_name: "User"
  belongs_to :player2, class_name: "User"
  belongs_to :player3, class_name: "User"
  belongs_to :player4, class_name: "User"

  def deal(num, user)
    puts num
    unless num <= 0
      deck = find_unowned_cards
      card = deck.shuffle.first
      CardOwnership.create(game: self, user: user, card: card)
      deal(num - 1, user)
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
end
