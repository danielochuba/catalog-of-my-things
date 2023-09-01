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
        item = double('item')  # Creating a double for the item (you can replace this with your actual Item class instance)

        expect(item).to receive(:genre=).with(genre)  # Expecting the item's genre setter to be called with the genre object
        expect(genre.items).to be_empty  # Initially, the genre's items array should be empty

        genre.add_item(item)

        expect(genre.items).to include(item)  # The item should now be in the genre's items array
        end
    end
end
