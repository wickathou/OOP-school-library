class Book
  attr_accessor :rentals
  attr_reader :title, :author, :id

  def initialize(id, title, author)
    @id = id
    @title = title
    @author = author
    @rentals = []
  end
end
