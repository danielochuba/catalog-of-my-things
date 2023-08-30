require 'date'

class Item

    attr_reader :id, :genre, :label, :author, :publish_date
    attr_accessor :archived
    def initialize(genre, author, label, date)
        @id = Random.rand(1..100)  
        @genre = genre
        @author = author
        @label = label
        @publish_date = date
        @archived = false
    end

    def genre=(genre)
        @genre = genre
        genre.add_item(self) unless genre.items.include?(self)
    end

    def author=(author)
        @author = author
        author.add_item(self) unless author.items.include?(self)
    end

    def label=(label)
        @label = label
        label.add_item(self) unless label.items.include?(self)
    end

    def move_to_archive
        @archived = true if can_be_archived?
    end

    private
    # should return true if published_date is older than 10 years Otherwise, it should return false
    def can_be_archived? 
        @publish_date.year < (Date.today.year - 10)
    end
end
