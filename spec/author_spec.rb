require_relative '../lib/item/author'
require_relative '../lib/item/item'
require 'date'

RSpec.describe Author do
  before :each do
    first_name = 'Stan'
    last_name = 'Lee'
    @author = Author.new(first_name, last_name)
  end

  describe 'new instance' do
    it 'have the correct first name' do
      result = @author.first_name
      expect(result).to eql('Stan')
    end

    it 'have the correct last name' do
      result = @author.last_name
      expect(result).to eql('Lee')
    end

    it 'have the id generated' do
      result = @author.id
      expect(result).to be_a(Numeric)
    end

    it 'have the add_item method that function correctly' do
      item = Item.new('2022-09-06')

      @author.add_item(item)
      result = @author.items

      expect(result.length).to eql(1)
    end

    it 'raised error if add wrong item type' do
      item = 's'
      expect { @author.add_item(item) }.to raise_error(ArgumentError, "'item' must be an instance of 'Item'")
    end
  end
end
