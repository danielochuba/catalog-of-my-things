require 'date'
require_relative 'genre'
require_relative 'author'
require_relative 'label'

class Item
  attr_reader :id, :genre, :label, :author, :publish_date
  attr_accessor :archived

  def initialize(genre, author, label, date)
    @id = Random.rand(1..100)

    @genre = genre
    genre.items << self

    @author = author
    author.items << self

    @label = label
    label.items << self

    @publish_date = date

    @archived = false
  end

  def move_to_archive
    if can_be_archived?
      @archived = true
      true
    else
      false
    end
  end

  private

  # should return true if published_date is older than 10 years Otherwise, it should return false
  def can_be_archived?
    @publish_date.year < (Date.today.year - 10)
  end
end
