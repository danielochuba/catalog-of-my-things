class Label
    attr_accessor :id, :title, :color
    attr_reader :items
    def initialize(title, color)
        @id = Random.rand(301..400)
        @title = title
        @color = color
        @items = []
    end

    def add_item(item)
        @items << item
        item.label = self

        item
    end
end