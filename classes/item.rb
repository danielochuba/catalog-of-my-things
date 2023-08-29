class Item
    def initialize(genre, author, label, date)
        @id = Random.rand(1..100)  
        @genre = genre
        @label = label
        @publish_date = date
        @archived = false
    end

    def move_to_archive
        @archived = true if can_be_archived?
    end

    private
    def can_be_archived?
        current_year = Time.now.year
        publication_year = @published_date.year
        years_since_publication = current_year - publication_year

        years_since_publication > 10
    end
end