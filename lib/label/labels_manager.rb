require 'json'

module LabelsManager
  def store_labels(all_labels)
    return if all_labels.empty?

    file = './Data/labels.json'
    File.new('./Data/labels.json', 'w+') unless File.exist?(file)

    data = []

    all_labels.each do |label|
      data << { id: label.id, title: label.title, color: label.color }
    end
    File.write(file, JSON.generate(data))
  end

  def fetch_labels
    file = './Data/labels.json'
    data = []

    return data unless File.exist?(file) && !File.empty?(file)

    JSON.parse(File.read(file)).each do |label|
      data << Label.new(label['title'], label['color'], label['id'])
    end
    data
  end

  def add_label?(item)
    print "Want to tag #{item.class.name} to an label (yes/no) "
    input = gets.chomp.downcase
    add_label_to_item(item) if input == 'yes'
  end

  def add_label_to_item(item)
    puts "Tag author to #{item.class.name}"
    print 'Create New label (1) or Choose Existing (2) (Write 1 or 2) '
    input = gets.chomp
    if input == '1'
      new_label = create_new_label
      new_label.add_item(item)
      puts "Label added to #{item.class.name} successfully"
    elsif input == '2'
      list_labels
      if @labels.length.positive?
        print 'Select label index (not id) '
        index = gets.chomp.to_i - 1
        selected_label = @labels[index]
        selected_label.add_item(item)
        puts "label added to #{item.class.name} successfully"
      end
    end
  end

  def create_new_label
    puts 'Create new Label'
    title = get_user_input("Label's title ")
    color = get_user_input('Label\'s color ')
    new_label = Label.new(title, color)
    @labels << new_label
    new_label
  end
end
