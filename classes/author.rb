class Author
    def initialize(first_name, last_name)
      @id = rand(201..300)
      @first_name = first_name
      @last_name = last_name
      @items = []
    end

    def add_item(item)
      @items << item

      item.author = self

      item
    end
end