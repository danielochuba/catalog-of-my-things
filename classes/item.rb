require 'date'

class Item
    def initialize(genre, author, label, date)
        @id = Random.rand(1..100)  
        @genre = genre
        @label = label
        @publish_date = date
        @archived = false
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
