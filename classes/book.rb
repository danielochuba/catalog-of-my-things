require_relative 'item'

class Book < Item
    def initialize(publisher, cover_state, genre, author, label, date)
        super(genre, author, label, date)
        @publisher = publisher
        @cover_state = cover_state        
    end

    def can_be_archived?
        super && @cover_state == 'bad'
    end
end