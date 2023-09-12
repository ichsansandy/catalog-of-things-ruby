require 'json'

module AuthorManager
  def store_author(all_author)
    return if all_author.empty?

    file = './Data/authors.json'
    File.new('./Data/authors.json', 'w+') unless File.exist?(file)

    data = []

    all_author.each do |author|
      data << { id: author.id, first_name: author.first_name, last_name: author.last_name}
    end
    File.write(file, JSON.generate(data))
  end

  def fetch_authors
    file = './Data/authors.json'
    data = []

    return data unless File.exist?(file) && !File.empty?(file)

    JSON.parse(File.read(file)).each do |author|
      new_author = Author.new(author['first_name'], author['last_name'],
                          author['id'])
      data << new_author
    end
    data
  end
end
