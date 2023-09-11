require_relative '../lib/item/author'
require_relative '../lib/item/item'
require 'date'

RSpec.describe Author do
  before :each do
    first_name = 'Stan'
    last_name = 'Lee'
    @Author = Author.new(first_name, last_name)
  end

  describe 'new instance' do
    it 'have the correct first name' do
      result = @Author.first_name
      expect(result).to eql('Stan')
    end

    it 'have the correct last name' do
      result = @Author.last_name
      expect(result).to eql('Lee')
    end

    it 'have the id generated' do
      result = @Author.id
      expect(result).to be_a(Numeric)
    end

    it 'have the add_item method that function correctly' do
      item = Item.new(Date.today)
      @Author.add_item(item)
      result = @Author.items
      expect(result.length).to eql(1)
    end

    it 'raised error if add wrong item type' do
      item = 's'
      expect{ @Author.add_item(item) }.to raise_error(ArgumentError, "'item' must be an instance of 'Item'")
    end
  end
end