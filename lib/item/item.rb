require 'date'

class Item
  attr_accessor :author, :label, :genre
  attr_reader :publish_date, :archived, :id

  def initialize(publish_date, id = Random.rand(1..1000), archived: false)
    @id = id
    @publish_date = Date.parse(publish_date)
    @archived = archived
  end

  def can_be_archived?
    (Date.today.year - @publish_date.year) > 10
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end
end
