require_relative 'item'

class Author
  attr_accessor :items
  attr_reader :id, :first_name, :last_name

  def initialize(first_name, last_name, id = Random.rand(1..1000))
    @id = id
    @first_name = first_name
    @last_name = last_name
    @items = []
  end

  def add_item(item)
    raise ArgumentError, "'item' must be an instance of 'Item'" unless item.is_a?(Item)

    @items << item
    item.author = self
  end
end
