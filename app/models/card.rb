class Card < ActiveRecord::Base

  validates :value,
    presence: true
end
