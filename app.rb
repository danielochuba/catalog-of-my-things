require 'json'
require 'date'
require './classes/item'
require './classes/genre'
require './classes/author'
require './classes/book'
require './classes/music_album'
require './classes/game'
require './classes/label'

module BookModule
  def create_book
    puts 'CREATING A NEW BOOK ...'
    puts
    genre = prompt_for_genre
    author = prompt_for_author
    label = prompt_for_label
    publisher = prompt_for_publisher
    cover_state = prompt_for_cover_state
    publish_date = prompt_for_publish_date

    book = Book.new(publisher, cover_state, genre, author, label, publish_date)
    book.move_to_archive

    @items << book
    @books << book

    store_books_to_json

    puts 'Book created successfully!'
    puts
  end

  def prompt_for_genre
    print 'Please enter genre: '
    genre = gets.chomp
    genre = Genre.new(genre) unless @genres.include?(genre)
    @genres << genre
    genre
  end

  def prompt_for_author
    puts 'Please enter author:'
    print 'Enter first name: '
    first_name = gets.chomp
    print 'Enter last name: '
    last_name = gets.chomp
    author = Author.new(first_name, last_name) unless @authors.include?(author)
    @authors << author
    author
  end

  def prompt_for_label
    puts 'Please enter the label details:'
    print '  Enter label title: '
    title = gets.chomp.to_s
    print '  Enter label color: '
    color = gets.chomp.to_s

    label = Label.new(title, color) unless @labels.include?(label)
    @labels << label
    label
  end

  def prompt_for_publisher
    print "Please enter the book's publisher: "
    gets.chomp.to_s
  end

  def prompt_for_cover_state
    puts 'Please enter the cover state:'
    print '  Enter cover state (good / bad): '
    cover_state = gets.chomp.downcase

    until %w[good bad].include?(cover_state)
      print '  Invalid input. Enter cover state (good / bad): '
      cover_state = gets.chomp.downcase
    end

    cover_state
  end

  def prompt_for_publish_date
    puts 'Please enter the publish date:'
    print '  Enter year: '
    year = gets.chomp.to_i

    print '  Enter month (01 - 12): '
    month = gets.chomp.to_i

    print '  Enter day (01 - 31): '
    day = gets.chomp.to_i

    begin
      publish_date = Date.new(year, month, day)
    rescue ArgumentError => e
      puts "  Error: #{e.message}. Please enter a valid date."
      publish_date = prompt_for_publish_date
    end

    publish_date
  end

  def store_books_to_json
    current_books = load_data('./store/books.json') || []
    book_to_store = current_books + @books.map do |book|
      {
        'id' => book.id,
        'genre' => book.genre.name,
        'title' => book.label.title,
        'color' => book.label.color,
        'author' => "#{book.author.first_name} #{book.author.last_name}",
        'publish_date' => book.publish_date,
        'publisher' => book.publisher,
        'cover_state' => book.cover_state,
        'archived' => book.archived
      }
    end
    store_data('./store/books.json', book_to_store)
  end

  def list_books
    books = load_data('./store/books.json')
    puts
    puts 'All books...'
    puts '***************'
    puts

    if books.empty?
      puts 'No books found.'
    else
      books.each do |book|
        puts "ID: #{book['id']} "
        puts "Genre: #{book['genre']}"
        puts "Author: #{book['author']}"
        puts "Label-- Title: #{book['title']} | Color: #{book['color']}"
        puts "Publish Date: #{book['publish_date']}"
        puts "Publisher: #{book['publisher']}"
        puts "Cover State: #{book['cover_state']}"
        puts "Archived: #{book['archived']}"
        puts '-----------------------------'
      end
    end
  end
end

module GameModule
  def create_game
    puts 'CREATING A NEW GAME...'
    puts

    genre = prompt_for_genre
    author = prompt_for_author
    label = prompt_for_label

    multiplayer = prompt_for_multiplayer
    publish_date = prompt_for_publish_date
    last_played_date = prompt_for_last_played_date

    game = Game.new(multiplayer, last_played_date, genre, author, label, publish_date)
    game.move_to_archive

    @items << game
    @games << game

    store_games_to_json

    puts 'Game created successfully!'
    puts
  end

  def prompt_for_multiplayer
    print 'Is the game multiplayer? (yes / no): '
    multiplayer_input = gets.chomp.to_s.downcase
    multiplayer_input == 'yes'
  end

  def prompt_for_last_played_date
    puts 'Please enter the last played date:'
    print '  Enter year: '
    year = gets.chomp.to_i

    print '  Enter month (01 - 12): '
    month = gets.chomp.to_i

    print '  Enter day (01 - 31): '
    day = gets.chomp.to_i

    begin
      last_played_date = Date.new(year, month, day)
    rescue ArgumentError => e
      puts "  Error: #{e.message}. Please enter a valid date."
      last_played_date = prompt_for_last_played_date
    end

    last_played_date
  end

  def store_games_to_json
    current_games = load_data('./store/games.json') || []
    games_to_store = current_games + @games.map do |game|
      {
        'id' => game.id,
        'genre' => game.genre.name,
        'title' => game.label.title,
        'color' => game.label.color,
        'author' => "#{game.author.first_name} #{game.author.last_name}",
        'publish_date' => game.publish_date,
        'multiplayer' => game.multiplayer,
        'last_played' => game.last_played,
        'archived' => game.archived
      }
    end

    store_data('./store/games.json', games_to_store)
  end

  def list_games
    games = load_data('./store/games.json')
    puts
    puts 'All games...'
    puts '***************'
    puts
    if games.empty?
      puts 'No games found!'
    else
      games.each do |game|
        puts "ID: #{game['id']}"
        puts "Genre: #{game['genre']}"
        puts "Author: #{game['author']}"
        puts "Label-- Title: #{game['title']} | Color: #{game['color']}"
        puts "Publish Date: #{game['publish_date']}"
        puts "Multiplayer: #{game['multiplayer']}"
        puts "Last Played: #{game['last_played']}"
        puts "Archived: #{game['archived']}"
        puts '-----------------------------'
      end
    end
  end
end

module MusicAlbumModule
  def create_music_album
    puts 'CREATING A NEW MUSIC ALBUM...'
    puts

    genre = prompt_for_genre
    author = prompt_for_author
    label = prompt_for_label

    on_spotify = prompt_for_on_spotify
    publish_date = prompt_for_publish_date

    music_album = MusicAlbum.new(on_spotify, genre, author, label, publish_date)
    music_album.move_to_archive

    @items << music_album
    @music_albums << music_album

    store_music_albums_to_json

    puts 'Music album created successfully!'
    puts
  end

  def prompt_for_on_spotify
    print 'Is the album on Spotify? (yes / no): '
    on_spotify_input = gets.chomp.to_s.downcase
    on_spotify_input == 'yes'
  end

  # Define methods for prompting for genre, author, label, and publish date similarly.

  def store_music_albums_to_json
    current_music_albums = load_data('./store/music_albums.json') || []
    music_album_to_store = current_music_albums + @music_albums.map do |music_album|
      {
        'id' => music_album.id,
        'genre' => music_album.genre.name,
        'title' => music_album.label.title,
        'color' => music_album.label.color,
        'author' => "#{music_album.author.first_name} #{music_album.author.last_name}",
        'publish_date' => music_album.publish_date,
        'on_spotify' => music_album.on_spotify,
        'archived' => music_album.archived
      }
    end

    store_data('./store/music_albums.json', music_album_to_store)
  end

  def list_music_albums
    music_albums = load_data('./store/music_albums.json')
    puts
    puts 'All music albums...'
    puts '***************'
    puts
    if music_albums.empty?
      puts 'No music albums found.'
    else
      music_albums.each do |music_album|
        puts "ID: #{music_album['id']}"
        puts "Genre: #{music_album['genre']}"
        puts "Author: #{music_album['author']}"
        puts "Label-- Title: #{music_album['title']} | Color: #{music_album['color']}"
        puts "Publish Date: #{music_album['publish_date']}"
        puts "On Spotify: #{music_album['on_spotify']}"
        puts "Archived: #{music_album['archived']}"
        puts '-----------------------------'
      end
    end
  end
end

module ListHandler
  def list_genres
    genres = load_data('./store/genres.json')
    puts
    puts 'All genres...'
    puts '***************'
    puts
    if genres.empty?
      puts 'No genres found!'
    else
      genres.each do |genre|
        puts "ID: #{genre['id']}"
        puts "Name: #{genre['name']}"
        puts '-----------------------------'
      end
    end
  end

  def list_authors
    authors = load_data('./store/authors.json')
    puts
    puts 'All authors...'
    puts '***************'
    puts
    if authors.empty?
      puts 'No authors found!'
    else
      authors.each do |author|
        puts "ID: #{author['id']}"
        puts "First Name: #{author['first_name']}"
        puts "Last Name: #{author['last_name']}"
        puts '-----------------------------'
      end
    end
  end

  def list_labels
    labels = load_data('./store/labels.json')
    puts
    puts 'All labels...'
    puts '***************'
    puts
    if labels.empty?
      puts 'No labels found!'
    else
      labels.each do |label|
        puts "ID: #{label['id']}"
        puts "Title: #{label['title']}"
        puts "Color: #{label['color']}"
        puts '-----------------------------'
      end
    end
  end

  def list_items
    puts
    puts 'All items...'
    puts '***************'
    puts

    @items.each do |item|
      puts item.type.upcase
      puts "ID: #{item.id}"
      puts "Genre: #{item.genre.name}"
      puts "Author: #{item.author.full_name}"
      puts "Label-- Title: #{item.label.title} | Color: #{item.label.color}"
      puts "Publish Date: #{item.publish_date}"

      case item
      when Book
        puts "Archived: #{item.archived}"
      when MusicAlbum
        puts "On Spotify: #{item.on_spotify}"
      when Game
        puts "Last Played Date: #{item.last_played}"
        puts "Multiplayer: #{item.multiplayer}"
      end

      puts '-----------------------------'
    end
  end
end

module StoreHandler
  def save_authors
    current_authors = load_data('./store/authors.json') || []
    authors_to_store = current_authors + @authors.map do |author|
      {
        'id' => author.id,
        'first_name' => author.first_name,
        'last_name' => author.last_name
      }
    end

    store_data('./store/authors.json', authors_to_store)
  end

  def save_labels
    current_labels = load_data('./store/labels.json') || []
    labels_to_store = current_labels + @labels.map do |label|
      {
        'id' => label.id,
        'title' => label.title,
        'color' => label.color
      }
    end

    store_data('./store/labels.json', labels_to_store)
  end

  def store_data(filename, data)
    File.write(filename, JSON.generate(data))
  rescue StandardError => e
    puts "Error writing file: #{e}"
  end

  def save_genres
    current_genres = load_data('./store/genres.json') || []
    genres_to_store = current_genres + @genres.map do |genre|
      {
        'id' => genre.id,
        'name' => genre.name
      }
    end

    store_data('./store/genres.json', genres_to_store)
  end
end

module LoadHandler
  def load_all_items
    @books = load_data('./store/books.json')
    @music_albums = load_data('./store/music_albums.json')
    @games = load_data('./store/games.json')
    @genres = load_data('./store/genres.json')
    @labels = load_data('./store/labels.json')
    @authors = load_data('./store/authors')
  end

  def load_data(filename)
    unless File.exist?(filename)
      File.open(filename, 'a')
      return []
    end

    data = File.read(filename)
    JSON.parse(data) unless data.empty?
  end
end

class App
  include BookModule
  include GameModule
  include MusicAlbumModule
  include ListHandler
  include StoreHandler
  include LoadHandler

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
    puts 'Please select an option:'
    puts '  1. Create a new book'
    puts '  2. Create a new music album'
    puts '  3. Create a new game'
    puts '  4. List all books'
    puts '  5. List all music albums'
    puts '  6. List all games'
    puts '  7. List all genres'
    puts '  8. List all labels'
    puts '  9. List all authors'
    puts ' 10. List all items'
    puts ' 11. Load items from JSON file'
    puts ' 12. Exit'
    puts
  end

  def process_input(input)
    case input
    when 1 then create_book
    when 2 then create_music_album
    when 3 then create_game
    when 4 then list_books
    when 5 then list_music_albums
    when 6 then list_games
    when 7 then list_genres
    when 8 then list_labels
    when 9 then list_authors
    when 10 then list_items
    when 11 then load_all_items
    when 12
      save_genres
      save_authors
      save_labels
      puts '  Thank you for using my app!.....Goodbye!'
      exit
    else
      puts 'Invalid input. Please try again.'
    end
  end
end
