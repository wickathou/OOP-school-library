require_relative 'lib/saveDecorators'
require_relative 'lib/rentals'
require_relative 'lib/person'
require_relative 'lib/student'
require_relative 'lib/book'
require_relative 'lib/classroom'

obj = {:test => 'test', :test2 => 'test2'}
obj[:test3] = 'test3'
puts obj

math_class = Classroom.new('Math')

student2 = Student.new(2, 15, 'John', true, math_class)
book1 = Book.new('The Noob', 'John Doe')

newRental = Rental.new('2021-01-01',book1, student2)
newRental2 = Rental.new('2021-01-02',book1, student2)
newRental3 = Rental.new('2021-01-03',book1, student2)
newRental4 = Rental.new('2021-01-04',book1, student2)

array = [newRental, newRental2, newRental3, newRental4]

tester = SaveRentalDecorator.new(array)

puts tester.instances

tester.save_routine