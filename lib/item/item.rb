class Item 

    def initialize()
      @id = Random.rand(1..1000)
      @publish_date = Date.now
      @archived = false
    end
    
    def can_be_archived?()
    end

end