require 'date'

class Item
  attr_reader :publish_date, :archived, :id, :author, :label, :genre

  def initialize(publish_date, id = nil, archived: false)
    @id = id || Random.rand(1..1000)
    @publish_date = Date.parse(publish_date)
    @archived = archived
  end

  def can_be_archived?
    (Date.today.year - @publish_date.year) > 10
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end

  def label=(label)
    @label = label
    @label = label.title
    label.items << self unless label.items.include?(self)
  end

  def author=(author)
    @author = author
    author.items << self unless author.items.include?(self)
  end

  def genre=(genre)
    @genre = genre
    genre.items << self unless genre.items.include?(self)
  end
end
