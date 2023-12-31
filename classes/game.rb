require_relative 'item'

class Game < Item
  attr_reader :multiplayer, :last_played

  def initialize(multiplayer, last_played, genre, author, label, date)
    super(genre, author, label, date)
    @multiplayer = multiplayer
    @last_played = last_played
  end

  private

  def can_be_archived?
    super && @last_played.year < (Date.today.year - 2)
  end
end
