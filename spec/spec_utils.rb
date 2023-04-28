require_relative '../lib/decorators'
require_relative '../lib/save_decorators'
require_relative '../lib/rentals'
require_relative '../lib/classroom'
require_relative '../lib/student'
require_relative '../lib/teacher'
require_relative '../lib/person'
require_relative '../lib/book'

require 'json'

def instance_creator
  [Book.new(0, '1984', 'George Orwell'), Person.new(0, 17, 'John Doe', true)]
end

def rental_generator(rentals, book, person)
  5.times { |i| rentals << Rental.new(i, book, person) }
end

def book_generator(books)
  5.times { |i| books << Book.new(i, instance_creator[0].title, instance_creator[0].author) }
end

def people_generator(people)
  5.times { |i| people << Person.new(i, instance_creator[1].age, instance_creator[1].name) }
end
