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

    def process_input(input)
        case input
        when 1
            create_book
        when 2
            create_music_album
        when 3
            create_game
        when 4
            list_books
        when 5
            list_music_albums
        when 6
            list_games
        when 7
            list_genres
        when 8
            list_labels
        when 9
            list_authors
        when 10
            list_items
        when 11
            archive_item
        when 12
            puts "  Thank you for using my app!.....Goodbye!"
            exit
        else
            puts "Invalid input. Please try again."
        end
    end


end
