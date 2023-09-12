class Item
  attr_reader :id, :genre, :author, :label
  attr_accessor :publish_date

  def initialize(publish_date, id = nil, archived: false)
    @id = id || Random.rand(1..1000)
    @publish_date = Date.parse(publish_date)
    @archived = archived
end

  def genre=(genre)
    @genre = genre
    genre.add_item(self) unless genre.add_item.include?(self)
  end

  def author=(author)
    @author = author
    author.items.push(self) unless author.items.include?(self)
  end

  def add_label=(label)
    @label = label
    label.add_items(self) unless label.add_items.include?(self)
  end

  def move_to_archive
    @archived = can_be_archived?
  end

  private

  def can_be_archived?
    (Date.today.year - @publish_date.year) > 10
end
end
