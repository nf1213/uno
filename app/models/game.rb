class Game < ActiveRecord::Base
  has_many :game_players, dependent: :destroy
  has_many :card_ownerships, dependent: :destroy

  def start(p1)
    robot = User.find_by_email("r@b.t")
    p2 = GamePlayer.create(game: self, user: robot)
    p3 = GamePlayer.create(game: self, user: robot)
    p4 = GamePlayer.create(game: self, user: robot)
    deal(7, p1)
    deal(7, p2)
    deal(7, p3)
    deal(7, p4)
    first = find_unowned_cards.shuffle.first
    update(last_played_id: first.id)
  end

  def deal(num, player)
    unless num <= 0
      card = find_unowned_cards.shuffle.first
      CardOwnership.create(game: self, game_player: player, card: card)
      deal(num - 1, player)
    end
  end

  def play_dummies
    game_players.where('user_id = 2').each do |robot|
      if no_cards_playable?(robot)
        deal(1, robot)
      else
        robot.cards.each do |card|
          if card.value.include?("Wild")
            CardOwnership.find_by_game_id_and_card_id(self.id, card.id).destroy
            color = ['red', 'green', 'yellow', 'blue'].shuffle.first
            last = Card.find_by_color_and_value(color, "wild")
            update(last_played_id: last.id)
            break
          else
            if can_play?(card)
              CardOwnership.find_by_game_id_and_card_id(self.id, card.id).destroy
              update(last_played_id: card.id)
              break
            end
          end
        end
      end
    end
  end

  def is_owned_in_game(card)
    if card.value.include?("Wild") && card.color != "wild"
      return true
    elsif CardOwnership.find_by_game_id_and_card_id(self.id, card.id).nil?
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

  def no_cards_playable?(player)
    player.cards.each do |card|
      if can_play?(card)
        return false
      end
    end
    true
  end

  def winner?
    game_players.each do |player|
      if player.cards.count == 0
        return true
      end
    end
    false
  end
end
