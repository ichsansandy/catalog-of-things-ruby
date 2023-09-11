require_relative '../item/item'

require 'date'

class Game < Item
  attr_reader :multiplayer, :last_played_at, :publish_date, :id, :archived

  def initialize(multiplayer, last_played_at, publish_date, id = Random.rand(1..1000), archived: false)
    super(publish_date, id, archived: archived)
    @multiplayer = multiplayer
    @last_played_at = Date.parse(last_played_at)
  end

  def can_be_archived?
    return true if super && (Date.today.year - @last_played_at.year) > 2

    false
  end
end
