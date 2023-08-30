require_relative 'item'

class MusicAlbum < Item
    
        attr_reader :on_spotify
    def initialize(spotify, genre, author, label, date)
        super(genre, author, label, date)
        @on_spotify = spotify
    end
    
    def can_be_archived?
        super && @on_spotify
    end
end