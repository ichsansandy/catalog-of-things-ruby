require_relative '../item/item'
require_relative '../item/genre'

class MusicAlbum < Item
  attr_reader :on_spotify, :publish_date

  def initialize(on_spotify, publish_date)
    super(publish_date)
    @on_spotify = on_spotify
  end

  def can_be_archived?
    super && on_spotify == true
  end
end
