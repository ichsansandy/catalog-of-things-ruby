require_relative 'lib/book/book'
require_relative 'lib/book/books_manager'
require_relative 'lib/label/labels_manager'
require_relative 'lib/label/label'
require_relative 'lib/music/music_album'
require_relative 'lib/music/music_list'
require_relative 'lib/game/game'
require_relative 'lib/game/game_manager'
require_relative 'lib/author/author'
require_relative 'lib/author/author_manager'

class Main
  include BooksManager
  include LabelsManager
  include GameManager
  include AuthorManager

  def initialize
    @music = MusicList.new
    @books = fetch_books
    @labels = fetch_labels
    @authors = fetch_authors
    @games = fetch_games(@authors)
  end

  puts "Welcome to Catalog of Things! \n\n"

  def menu
    puts 'Choose an option:'
    puts '1. List all books'
    puts '2. List all music albums'
    puts '3. List of games'
    puts '4. List all genres (e.g \'Comedy\', \'Thriller\')'
    puts '5. List all labels (e.g \'Gift\', \'New\')'
    puts '6. List all authors (e.g \'Stephen King\', \'JK Rowling\')'
    puts '7. Add a books'
    puts '8. Add a music albums'
    puts '9. Add a games'
    puts '10. Exit'
  end

  def start
    loop do
      menu
      option = gets.chomp
      handle_option(option)
      break if option == '10'
    end
    puts 'Thank you for using this app!'
    store_books(@books)
    store_labels(@labels)
  end

  def handle_option(option)
    option_actions = {
      '1' => method(:list_books),
      '2' => method(:list_all_music_albums),
      '3' => method(:list_all_game),
      '4' => method(:list_all_genre),
      '5' => method(:list_labels),
      '6' => method(:list_all_author),
      '7' => method(:add_book),
      '8' => method(:add_music_album),
      '9' => method(:add_new_game)
    }

    action = option_actions[option]
    action&.call
  end

  def add_book
    author = get_user_input("Book's author")
    publish_date = get_user_input("Book's publish date")
    publisher = get_user_input("Book's publisher")
    get_user_input("Book's cover state(good, bad) ")
    genre = get_user_input("Book's genre")
    title = get_user_input("Book's label")
    color = get_user_input('Color')

    label = create_label(title, color)
    book = create_book(publish_date, publisher, genre, label, author)

    book.move_to_archive

    @books << book
    @labels << label

    puts 'Label added successfully'
    puts "Book by (#{author}) created successfully"
  end

  def create_label(title, color)
    Label.new(title, color)
  end

  def create_book(publish_date, publisher, genre, label, author)
    book = Book.new(publish_date, publisher)
    book.genre = genre
    book.label = label
    book.author = author
    book
  end

  def get_user_input(prompt)
    print "#{prompt}: "
    gets.chomp
  end

  def list_books
    puts '-' * 30
    if @books.empty?
      puts 'No books yet!'
    else
      puts 'The list Books: '
      @books.each_with_index do |book, index|
        puts "#{index + 1}-[Book] ID: #{book.id} - Publisher: #{book.publisher} - " \
             "Publish date: #{book.publish_date} - Cover state: #{book.cover_state} - Archived: #{book.archived}"
      end
    end
  end

  def list_labels
    puts '-' * 30
    if @labels.empty?
      puts 'No labels yet!'
    else
      puts 'The list Labels: '
      @labels.each_with_index do |label, _index|
        puts "Title: #{label.title} - Color: #{label.color}"
      end
    end
  end

  def add_new_game
    new_game = add_game
    add_author?(new_game)
    @games << new_game
    store_games(@games)
  end

  def list_all_music_albums
    @music.list_all_music_albums
  end

  def list_all_genre
    @music.list_all_genre
  end

  def add_music_album
    @music.add_music_album
  end
end

main = Main.new
main.start
