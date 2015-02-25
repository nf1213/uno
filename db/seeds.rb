# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

## Create Uno Deck
Card.destroy_all


["red", "blue", "green", "yellow"].each do |color|
  2.times do
    (1..9).each do |i|
      Card.create(color: color, value: i.to_s)
    end
    Card.create(color: color, value: "Draw Two")
    Card.create(color: color, value: "Skip")
    Card.create(color: color, value: "Reverse")
  end
  Card.create(color: color, value: 0.to_s)
  Card.create(color: color, value: "Wild")
end

4.times do
  Card.create(color: "wild", value: "Wild")
  Card.create(color: "wild", value: "WildDrawFour")
end
