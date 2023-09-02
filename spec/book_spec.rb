require_relative '../classes/book'
require 'date'

RSpec.describe Book do
  describe '#can_be_archived?' do
    context 'Can be archived when the cover state is bad and publisher date is less than 10 years' do
      it 'returns true' do
        publisher = 'Publisher'
        cover_state = 'bad'
        genre = Genre.new('Genre')
        author = Author.new('Author', 'Last Name')
        label = Label.new('Label', 'green')
        date = Date.new(2020, 1, 1)

        book = Book.new(publisher, cover_state, genre, author, label, date)

        expect(book.move_to_archive).to be(true)
      end
    end

    context 'when the cover state is good and publisher date is less than 10 years' do
      it 'returns false' do
        publisher = 'Publisher'
        cover_state = 'good'
        genre = Genre.new('Genre')
        author = Author.new('Author', 'Last Name')
        label = Label.new('Label', 'green')
        date = Date.new(2020, 1, 1)

        book = Book.new(publisher, cover_state, genre, author, label, date)
        expect(book.move_to_archive).to be(false)
      end
    end

    context 'when the cover state is good and publisher date is upto 10 years' do
      it 'returns false' do
        publisher = 'Publisher'
        cover_state = 'good'
        genre = Genre.new('Genre')
        author = Author.new('Author', 'Last Name')
        label = Label.new('Label', 'green')
        date = Date.new(2010, 1, 1)

        book = Book.new(publisher, cover_state, genre, author, label, date)
        expect(book.move_to_archive).to be(true)
      end
    end
  end
end
