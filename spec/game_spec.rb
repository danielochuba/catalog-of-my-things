require_relative '../classes/game'

RSpec.describe Game do

    describe '#can_be_archived?' do
    
        context 'when the last played date is less than 2 years' do
        it 'returns false' do
            multiplayer = true
            last_played = Date.new(2020, 1, 1)
            genre = Genre.new('Genre')
            author = Author.new('Author', 'Last Name')
            label = Label.new('Label', 'green')
            date = Date.new(2020, 1, 1)
    
            game = Game.new(multiplayer, last_played, genre, author, label, date)
            
            expect(game.move_to_archive).to be(false)
        end
        end
    
        context 'when the last played date is upto 2 years' do
            it 'returns true' do
                multiplayer = true
                last_played = Date.new(2010, 1, 1)
                genre = Genre.new('Genre')
                author = Author.new('Author', 'Last Name')
                label = Label.new('Label', 'green')
                date = Date.new(2010, 1, 1)
    
                game = Game.new(multiplayer, last_played, genre, author, label, date)
                expect(game.move_to_archive).to be(true)
            end
        end

        context 'when the last played date is upto 2 years and publish date is less 10' do
            it 'returns false' do
                multiplayer = true
                last_played = Date.new(2010, 1, 1)
                genre = Genre.new('Genre')
                author = Author.new('Author', 'Last Name')
                label = Label.new('Label', 'green')
                date = Date.new(2020, 1, 1)    
                game = Game.new(multiplayer, last_played, genre, author, label, date)
                expect(game.move_to_archive).to be(false)
            end
        end
       
    end
    end