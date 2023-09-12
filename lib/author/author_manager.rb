require 'json'

module AuthorManager
  def store_author(all_author)
    return if all_author.empty?

    file = './Data/authors.json'
    File.new('./Data/authors.json', 'w+') unless File.exist?(file)

    data = []

    all_author.each do |author|
      data << { id: author.id, first_name: author.first_name, last_name: author.last_name }
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

  def add_author?(item)
    print "Want to tag #{item.class.name} to an Author (yes/no)"
    input = gets.chomp.downcase
    add_author_to_item(item) if input == 'yes'
  end

  def add_author_to_item(item)
    puts "Tag author to #{item.class.name}"
    print 'Create New Author (1) or Choose Existing (2) (Write 1 or 2)'
    input = gets.chomp
    if input == '1'
      new_author = create_new_author
      new_author.add_item(item)
      puts "Author added to #{item.class.name} successfully"
    elsif input == '2'
      list_all_author
      if @authors.length.positive?
        print 'Select author index'
        index = gets.chomp.to_i - 1
        selected_author = @authors[index]
        selected_author.add_item(item)
        puts "Author added to #{item.class.name} successfully"
      end
    end
  end

  def create_new_author
    puts 'Create New Author'
    print 'First name:'
    first_name = gets.chomp
    print 'Last name:'
    last_name = gets.chomp
    new_author = Author.new(first_name, last_name)
    @authors << new_author
    store_author(@authors)
    puts 'Author Created'
    new_author
  end

  def list_all_author
    puts '-' * 50
    if @authors.empty?
      puts 'No author yet!'
    else
      puts 'The Author List: '
      @authors.each_with_index do |author, index|
        puts "#{index + 1} - [Author] ID: #{author.id} - " \
             "Firstname: #{author.first_name} - Lastname: #{author.last_name} "
      end
    end
    puts '-' * 50
  end
end
