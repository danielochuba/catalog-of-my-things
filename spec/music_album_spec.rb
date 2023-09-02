require_relative '../classes/music_album'

RSpec.describe MusicAlbum do
  describe '#can_be_archived?' do
    context 'when the publisher date is less than 10 years' do
      it 'returns false' do
        on_spotify = true
        genre = Genre.new('Genre')
        author = Author.new('Author', 'Last Name')
        label = Label.new('Label', 'green')
        date = Date.new(2020, 1, 1)

        music_album = MusicAlbum.new(on_spotify, genre, author, label, date)

        expect(music_album.move_to_archive).to be(false)
      end
    end

    context 'when the publisher date is upto 10 years' do
      it 'returns true' do
        on_spotify = true
        genre = Genre.new('Genre')
        author = Author.new('Author', 'Last Name')
        label = Label.new('Label', 'green')
        date = Date.new(2010, 1, 1)

        music_album = MusicAlbum.new(on_spotify, genre, author, label, date)
        expect(music_album.move_to_archive).to be(true)
      end
    end
  end
end
