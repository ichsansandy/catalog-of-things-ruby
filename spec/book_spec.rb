require_relative '../lib/book/book'
require_relative '../lib/book/books_manager'
require_relative '../lib/item/item'
require 'date'

describe Book do
  include BooksManager

  it 'Should create an instance of the Book class' do
    date = '2023-09-10'
    book = Book.new(date, 'moha', 'good')
    expect(book).to be_instance_of Book
  end

  it 'can be archived should return true' do
    book = Book.new('2011-09-9', 'Adeeb', 'good')
    expect(book.can_be_archived?).to be true
  end

  it 'can be archived should return false' do
    book = Book.new('2023-09-9', 'Adeeb', 'good')
    expect(book.can_be_archived?).to be false
  end

  it 'should store books in json files' do
    books = [Book.new('2023-09-09', 'Fuhidy', 'good'), Book.new('2023-07-09', 'Adeeb', 'bad')]
    store_books(books)
    expect(File.exist?('./Data/books.json') && File.read('./Data/books.json') != '').to eq true
  end

end
