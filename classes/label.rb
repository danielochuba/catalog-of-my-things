class Label
    def initialize(title, color)
        @id = Random.rand(301..400)
        @title = title
        @color = color
        @items = []
    end

    def add_item(item)
        @items << item
        item.label = self
    end
end