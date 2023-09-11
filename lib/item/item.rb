require 'date'

class Item 
    def initialize(id, publish_date, archived)
      @id = Random.rand(1..1000)
      @publish_date = Date.parse(publish_date)
      @archived = archived
    end
    
    def can_be_archived?
        (Date.today.year - @publish_date.year) > 10
    end

  def move_to_archive
    @archived = true if can_be_archived?
  end

end