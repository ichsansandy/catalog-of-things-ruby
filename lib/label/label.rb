require_relative 'item'

class Label
  attr_accessor :items, :title, :color, :id

  def initialize(title, color, id = nil)
    @id = id || Random.rand(1..1000)
    @title = title
    @color = color
    @items = []
  end

  def add_item(item)
    raise ArgumentError, "'item' must be an instance of 'Item'" unless item.is_a?(Item)

    @items << item
    item.label = self
  end
end
