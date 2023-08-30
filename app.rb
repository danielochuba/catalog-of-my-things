require 'date'
require './classes/item'
require './classes/genre'
require './classes/author'
require './classes/book'
require './classes/music_album'
require './classes/game'
require './classes/label'


class App
    def initialize
        @genres = []
        @books = []
        @music_albums = []
        @games = []
        @authors = []
        @labels = []
        @items = []        
    end

    def display_options
        
        puts "Please select an option:"
        puts "  1. Create a new book"
        puts "  2. Create a new music album"
        puts "  3. Create a new game"
        puts "  4. List all books"
        puts "  5. List all music albums"
        puts "  6. List all games"
        puts "  7. List all genres"
        puts "  8. List all labels"
        puts "  9. List all authors"
        puts " 10. List all items"
        puts " 11. Archive an item"
        puts " 12. Exit"
        puts
    end


end
