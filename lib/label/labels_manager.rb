require 'json'

module LabelManager
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

  def get_books
    file = './Data/labels.json'
    data = []

    return data unless File.exist?(file) && !File.empty?(file)

    JSON.parse(File.read(file)).each do |label|
      data << Label.new(label['title'], label['color'], label['id'])
    end
    data
  end
end
