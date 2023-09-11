require 'json'

module BooksManager
  def store_books(all_books)
    file = './data/books.json'
    File.new('books.json', 'w+') unless File.exist?(file)

    data = []

    all_books.each do |book|
      data << { id: book.id, publish_date: book.publish_date, publisher: book.publisher, cover_state: book.cover_state,
                archived: book.archived, genre: book.genre, author: book.author, label: book.label }
    end
    File.write(file, JSON.generate(data))
  end

  def get_books
     file = './data/books.json'
    data = []

    return data unless File.exist?(file) && !File.empty?(file)

    JSON.parse(File.read(file)).each do |book|
      book = Book.new(book['publish_date'], book['publisher'], book['cover_state'], book['id'],
                      archived: book['archived'])
      book.genre = book['genre']
      book.label = book['label']
      book.author = book['author']

      data << book
    end
    data
  end
end
