class Genre
  attr_reader :id, :items
  attr_accessor :name

  def initialize(name)
    @id = Random.rand(101..200)
    @name = name
    @items = []
  end

  def add_item(item)
    @items << item
    item.genre = self

    item
  end
end
