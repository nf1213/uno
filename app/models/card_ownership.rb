class CardOwnership < ActiveRecord::Base
  belongs_to :card
  belongs_to :user
  belongs_to :game

  validates :card,
    uniqueness: {scope: :game_id},
    presence: true

  validates :user,
    presence: true

  validates :game,
    presence: true
end
