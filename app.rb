require 'json'
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
        load_genres
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
            save_genres
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

        book_to_store = @books.map do |book| {
            "id" => book.id,
            "genre" => book.genre.name,
            "title" => book.label.title,
            "color" => book.label.color,
            "author" => book.author.first_name + " " + book.author.last_name,
            "publish_date" => book.publish_date,
            "publisher" => book.publisher,
            "cover_state" => book.cover_state,
            "archived" => book.archived
        }
        end

        store_data('./store/books.json', book_to_store)


        puts "Book created successfully!"
        puts
    end

    def list_books
        load_books('./store/books.json')
        puts
        puts "All books..."
        puts "***************"
        puts
        if !@books.empty? 
            @books.each do |book|
                puts "ID: #{book["id"]}"
                puts "Genre: #{book["genre"]}"
                puts "Author: #{book["author"]}"
                puts "Label-- Title: #{book["title"]} | Color: #{book["color"]}"
                puts "Publish Date: #{book["publish_date"]}"
                puts "Publisher: #{book["publisher"]}"
                puts "Cover State: #{book["cover_state"]}"
                puts "Archived: #{book["archived"]}"
                puts "-----------------------------"
            end
        else
            puts "No books found."
        end
    end

    def create_music_album
        puts "  CREATING A NEW MUSIC ALBUM..."
        puts
        print "Please enter the music album's genre:  "
        genre = gets.chomp
        genre = Genre.new(genre) unless @genres.include?(genre)
        @genres << genre

        puts
        puts "Please enter the music album's author:  "
        puts
        print "  Enter first name:  "
        first_name = gets.chomp.to_s
        print "  Enter last name:  "
        last_name = gets.chomp.to_s

        author = Author.new(first_name, last_name) unless @authors.include?(author)
        @authors << author

        puts
        puts "Please enter the music album's label:"
        puts
        print "  Enter album title:  "
        title = gets.chomp.to_s
        print "  Enter album color:  "
        color = gets.chomp.to_s
        
        label = Label.new(title, color) unless @labels.include?(label)
        @labels << label

        puts
        print "Is album on Spotify? (yes / no):  "
        on_spotify = gets.chomp.to_s.downcase

        if on_spotify == "yes"
            on_spotify = true
        else
            on_spotify = false
        end
        
        puts
        puts "Please enter the music album's publish date: "
        puts
        print "  Enter year:  "
        year = gets.chomp

        print "  Enter month: (01 - 12):  "
        month = gets.chomp

        print "  Enter day: (01 - 31):  "
        day = gets.chomp

        publish_date = Date.new(year.to_i, month.to_i, day.to_i)

        music_album = MusicAlbum.new(on_spotify, genre, author, label, publish_date)
        music_album.move_to_archive
        @items << music_album
        @music_albums << music_album

        music_album_to_store = @music_albums.map do |music_album| {
            "id" => music_album.id,
            "genre" => music_album.genre.name,
            "title" => music_album.label.title,
            "color" => music_album.label.color,
            "author" => music_album.author.first_name + " " + music_album.author.last_name,
            "publish_date" => music_album.publish_date,
            "on_spotify" => music_album.on_spotify,
            "archived" => music_album.archived
        }
        end

        store_data('./store/music_albums.json', music_album_to_store)

        puts
        puts "Music album created successfully!"
        puts
    end

    def list_music_albums
        load_music_albums('./store/music_albums.json')
        puts
        puts "All music albums..."
        puts "***************"
        puts
        @music_albums.each do |music_album|
            puts "ID: #{music_album["id"]}"
            puts "Genre: #{music_album["genre"]}"
            puts "Author: #{music_album["author"]}"
            puts "Label-- Title: #{music_album["title"]} | Color: #{music_album["color"]}"
            puts "Publish Date: #{music_album["publish_date"]}"
            puts "On Spotify: #{music_album["on_spotify"]}"
            puts "Archived: #{music_album["archived"]}"
            puts "-----------------------------"
        end
    end

    def create_game
        puts "  CREATING A NEW GAME..."
        puts
        print "Please enter the game's genre:  "
        genre = gets.chomp
        genre = Genre.new(genre) unless @genres.include?(genre)
        @genres << genre

        puts
        puts "Please enter the game's author:  "
        puts
        print "  Enter first name:  "
        first_name = gets.chomp.to_s
        print "  Enter last name:  "
        last_name = gets.chomp.to_s

        author = Author.new(first_name, last_name) unless @authors.include?(author)
        @authors << author

        puts
        puts "Please enter the game's label:"
        puts
        print "  Enter game title:  "
        title = gets.chomp.to_s
        print "  Enter game color:  "
        color = gets.chomp.to_s

        label = Label.new(title, color) unless @labels.include?(label)
        @labels << label

        puts
        print "Is game a multiplayer ? (yes / no):  "
        multiplayer = gets.chomp.to_s.downcase

        if multiplayer == "yes"
            multiplayer = true
        else
            multiplayer = false
        end

        puts
        puts "Please enter the game's publish date: "
        puts
        print "  Enter year:  "
        year = gets.chomp

        print "  Enter month: (01 - 12):  "
        month = gets.chomp

        print "  Enter day: (01 - 31):  "
        day = gets.chomp

        publish_date = Date.new(year.to_i, month.to_i, day.to_i)

        puts
        puts "Please enter the game's last played date: "
        puts

        print "  Enter year:  "
        year = gets.chomp
        
        print "  Enter month: (01 - 12):  "
        month = gets.chomp

        print "  Enter day: (01 - 31):  "
        day = gets.chomp

        last_played_date = Date.new(year.to_i, month.to_i, day.to_i)
         

        game = Game.new(multiplayer, last_played_date, genre, author, label, publish_date)
        game.move_to_archive
        @items << game
        @games << game

        game_to_store = @games.map do |game| {
            "id" => game.id,
            "genre" => game.genre.name,
            "title" => game.label.title,
            "color" => game.label.color,
            "author" => game.author.first_name + " " + game.author.last_name,
            "publish_date" => game.publish_date,
            "multiplayer" => game.multiplayer,
            "last_played" => game.last_played,
            "archived" => game.archived
        }
        end

        store_data('./store/games.json', game_to_store)

        puts "Game created successfully!"
        puts
    end

    def list_games
        load_games('./store/games.json')
        puts
        puts "All games..."
        puts "***************"
        puts
        @games.each do |game|
            puts "ID: #{game["id"]}"
            puts "Genre: #{game["genre"]}"
            puts "Author: #{game["author"]}"
            puts "Label-- Title: #{game["title"]} | Color: #{game["color"]}"
            puts "Publish Date: #{game["publish_date"]}"
            puts "Multiplayer: #{game["multiplayer"]}"
            puts "Last Played: #{game["last_played"]}"
            puts "Archived: #{game["archived"]}"
            puts "-----------------------------"
        end
    end

    def list_genres
        puts
        puts "All genres..."
        puts "***************"
        puts
        @genres.each do |genre|
            puts "ID: #{genre.id}"
            puts "Name: #{genre.name}"
            puts "-----------------------------"
        end
    end

    def list_authors
        puts
        puts "All authors..."
        puts "***************"
        puts
        @authors.each do |author|
            puts "ID: #{author.id}"
            puts "First Name: #{author.first_name}"
            puts "Last Name: #{author.last_name}"
            puts "-----------------------------"
        end
    end

    def list_labels
        puts
        puts "All labels..."
        puts "***************"
        puts
        @labels.each do |label|
            puts "ID: #{label.id}"
            puts "Title: #{label.title}"
            puts "Color: #{label.color}"
            puts "-----------------------------"
        end
    end

    def list_items
        puts
        puts "All items..."
        puts "***************"
        puts
        @items.each do |item|
                if item.instance_of?(Book)
                puts 'BOOk'
                   puts "ID: #{item.id}"
                    puts "Genre: #{item.genre.name}"
                    puts "Author: #{item.author.first_name} #{item.author.last_name}"
                    puts "Label-- Title: #{item.label.title} | Color: #{item.label.color}"
                    puts "Publish Date: #{item.publish_date}"
                    puts "Archived: #{item.archived}"
                    puts "-----------------------------"
                elsif item.instance_of?(MusicAlbum)
                    puts 'MUSIC_ALBUM'
                    puts "ID: #{item.id}"
                    puts "Genre: #{item.genre.name}"
                    puts "Author: #{item.author.first_name} #{item.author.last_name}"
                    puts "Label-- Title: #{item.label.title} | Color: #{item.label.color}"
                    puts "Publish Date: #{item.publish_date}"
                    puts "On Spotify: #{item.on_spotify}"
                    puts "Archived: #{item.archived}"
                    puts "-----------------------------"
                elsif item.instance_of?(Game)
                    puts 'GAME'
                    puts "ID: #{item.id}"
                    puts "Genre: #{item.genre.name}"
                    puts "Author: #{item.author.first_name} #{item.author.last_name}"
                    puts "Label-- Title: #{item.label.title} | Color: #{item.label.color}"
                    puts "Publish Date: #{item.publish_date}"
                    puts "Last Played Date: #{item.last_played}"
                    puts "Multiplayer: #{item.multiplayer}"
                    puts "Archived: #{item.archived}"
                    puts "-----------------------------"
                end 
                     
        end
    end

    def store_data(filename, data)
        File.write(filename, JSON.generate(data))
      rescue StandardError => e
        puts "Error writing file: #{e}"
    end

    def load_books(filename)
       @books = JSON.parse(File.read(filename))
      rescue StandardError => e
        puts "Error loading file: #{e}"
    end

    def load_music_albums(filename)
        @music_albums = JSON.parse(File.read(filename))
      rescue StandardError => e
        puts "Error loading file: #{e}"
    end

    def load_games(filename)
        @games = JSON.parse(File.read(filename))
      rescue StandardError => e
        puts "Error loading file: #{e}"
    end

    def load_genres
        @genres = JSON.parse(File.read('./store/genres.json'))
      rescue StandardError => e
        puts "Error loading file: #{e}"
    end

    def save_genres
        genres_to_store = @genres.map do |genre| {
            "id" => genre.id,
            "name" => genre.name
        }
        end

        store_data('./store/genres.json', genres_to_store)
    end
    
end
