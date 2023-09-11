require_relative 'lib/book/book'
require_relative 'lib/book/books_manager'
require_relative 'lib/label/labels_manager'
require_relative 'lib/label/label'

class Main
  include BooksManager
  include LabelsManager
  def initialize
    @books = fetch_books
    @labels = fetch_labels
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
      case option
      when '1'
        list_books
      when '2'
        puts '2'
      when '3'
        puts '3'
      when '4'
        puts '4'
      when '5'
        list_labels
      when '6'
        puts '6'
      when '7'
        add_book
      when '8'
        puts '8'
      when '9'
        puts '9'
      when '10'
        print 'Thank you for using this app!'
        store_books(@books)
        store_labels(@labels)
        break
      end
      puts "\n"
    end
  end

  def add_book
    author = get_user_input("Book's author")
    publish_date = get_user_input("Book's publish date")
    publisher = get_user_input("Book's publisher")
    cover_state = get_user_input("Book's cover state(good, bad) ")
    genre = get_user_input("Book's genre")
    title = get_user_input("Book's label")
    color = get_user_input('Color')

    label = create_label(title, color)
    book = create_book(publish_date, publisher, cover_state, genre, label, author)

    book.move_to_archive

    @books << book
    @labels << label

    puts 'Label added successfully'
    puts "Book by (#{author}) created successfully"
  end

  def get_user_input(prompt)
    print "#{prompt}: "
    gets.chomp
  end

  def create_label(title, color)
    Label.new(title, color)
  end

  def create_book(publish_date, publisher, cover_state, genre, label, author)
    book = Book.new(publish_date, publisher, cover_state)
    book.genre = genre
    book.label = label
    book.author = author
    book
  end

  def get_user_input(prompt)
    print "#{prompt}: "
    gets.chomp
  end

  def create_label(title, color)
    Label.new(title, color)
  end

  def create_book(publish_date, publisher, cover_state, genre, label, author)
    book = Book.new(publish_date, publisher, cover_state)
    book.genre = genre
    book.label = label
    book.author = author
    book
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
end

main = Main.new
main.start
