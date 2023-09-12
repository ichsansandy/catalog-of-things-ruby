require 'json'

module BooksManager
  def store_books(all_books)
    return if all_books.empty?

    file = './Data/books.json'
    File.new('./Data/books.json', 'w+') unless File.exist?(file)

    data = []

    all_books.each do |book|
      data << { id: book.id, publish_date: book.publish_date, publisher: book.publisher, cover_state: book.cover_state,
                archived: book.archived, genre: book.genre, author: book.author, label: book.label }
    end
    File.write(file, JSON.generate(data))
  end

  def fetch_books
    file = './Data/books.json'
    data = []

    return data unless File.exist?(file) && !File.empty?(file)

    JSON.parse(File.read(file)).each do |book|
      new_book = Book.new(book['publish_date'], book['publisher'], book['cover_state'], book['id'],
                          archived: book['archived'])

      # new_book.genre = book['genre']
      new_book.label = Label.new(book['label'], book['color'])
      # new_book.author = book['author']

      data << new_book
    end
    data
  end
end
