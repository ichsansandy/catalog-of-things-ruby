require_relative 'lib/book/book'
require_relative 'lib/book/books_manager'

class Main
  include BooksManager
  def initialize
    @books = get_books
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
        puts '5'
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
        break
      end

      puts "\n"
    end
  end

  def add_book
    print "Book's author: "
    author = gets.chomp
    print "Book's publish date: "
    publish_date = gets.chomp
    print "Book's publisher: "
    publisher = gets.chomp
    print "Book's cover state(good, bad): "
    cover_state = gets.chomp
    print "Book's genre: "
    genre = gets.chomp
    print "Book's label: "
    label = gets.chomp
    book = Book.new(publish_date, publisher, cover_state)
    book.genre = genre
    book.label = label
    book.author = author
    book.move_to_archive
    @books << book
    puts "Book by (#{author}) created successfully"
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
end
