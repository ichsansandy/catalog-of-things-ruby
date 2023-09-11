require_relative '../lib/game/game'
require_relative '../lib/item/author'
require 'date'

RSpec.describe Game do
  before :each do
    multiplayer = true
    last_played_at = '2020-12-06'
    publish_date = '2010-10-10'
    @game = Game.new(multiplayer, last_played_at, publish_date)
  end

  describe 'instance' do
    it 'will have the correct property multiplayer' do
      result = @game.multiplayer
      expect(result).to eq(true)
    end

    it 'will have the correct property publish_date' do
      result = @game.publish_date.to_s
      expect(result).to eq('2010-10-10')
    end

    it 'have the id generated' do
      result = @game.id
      expect(result).to be_a(Numeric)
    end

    it 'can_be_archived? method funstion correctly' do
      result = @game.can_be_archived?
      expect(result).to be true
    end
  end
end
