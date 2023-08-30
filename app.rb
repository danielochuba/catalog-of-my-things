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

    def create_book
        puts "  CREATING A NEW BOOK ..."
        puts
        print "Please enter the book's genre:  "
        genre = gets.chomp
        genre = Genre.new(genre) unless @genres.include?(genre)
        @genres << genre

        puts
        puts "Please enter the book's author:  "
        puts
        print "Enter first name:  "
        first_name = gets.chomp.to_s
        print "Enter last name:  "
        last_name = gets.chomp.to_s

        author = Author.new(first_name, last_name) unless @authors.include?(author)
        @authors << author

        puts
        puts "Please enter the book's label:"
        puts
        print "  Enter book title:  "
        title = gets.chomp.to_s
        print "  Enter book color:  "
        color = gets.chomp.to_s

        label = Label.new(title, color) unless @labels.include?(label)
        @labels << label

        puts
        print "Please enter the book's publisher:  "
        publisher = gets.chomp
        puts
        print "Please enter the book's cover state: (good / bad) "
        cover_state = gets.chomp.to_s.downcase

        puts
        puts "Please enter the book's publish date: "
        puts
        print "  Enter year:  "
        year = gets.chomp

        print "  Enter month: (01 - 12):  "
        month = gets.chomp

        print "  Enter day: (01 - 31):  "
        day = gets.chomp

        publish_date = Date.new(year.to_i, month.to_i, day.to_i)

        book = Book.new(publisher, cover_state, genre, author, label, publish_date)
        book.move_to_archive
        @items << book
        @books << book

        puts "Book created successfully!"
        puts
    end

    def list_books
        puts
        puts "All books..."
        puts "***************"
        puts
        @books.each do |book|
            puts "ID: #{book.id}"
            puts "Genre: #{book.genre.name}"
            puts "Author: #{book.author.first_name} #{book.author.last_name}"
            puts "Label-- Title: #{book.label.title} | Color: #{book.label.color}"
            puts "Publish Date: #{book.publish_date}"
            puts "Publisher: #{book.publisher}"
            puts "Cover State: #{book.cover_state}"
            puts "Archived: #{book.archived}"
            puts "-----------------------------"
        end
    end

end
