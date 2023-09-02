require_relative '../classes/genre'

RSpec.describe Genre do
  describe '#initialize' do
    it 'creates a new instance of Genre' do
      genre = Genre.new('Genre')
      expect(genre).to be_an_instance_of(Genre)
    end
  end

  describe '#add_item' do
    it 'adds an item to the genre' do
      genre = Genre.new('Genre Name')
      item = double('item')

      expect(item).to receive(:genre=).with(genre)
      expect(genre.items).to be_empty

      genre.add_item(item)

      expect(genre.items).to include(item)
    end
  end
end
