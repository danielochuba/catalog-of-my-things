require_relative 'item'

class Book < Item
  attr_reader :publisher, :cover_state

  def initialize(publisher, cover_state, genre, author, label, date)
    super(genre, author, label, date)
    @publisher = publisher
    @cover_state = cover_state
  end

  private

  def can_be_archived?
    super || @cover_state == 'bad'
  end
end
