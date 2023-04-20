require_relative 'student'
require_relative 'book'
require_relative 'rentals'
require_relative 'classroom'

math_class = Classroom.new('Math')

student1 = Student.new(1, 22, 'Mark', true, math_class)
puts student1.can_use_services?
puts student1.play_hooky

student2 = Student.new(2, 15, 'John', true, math_class)
puts student2.can_use_services?
puts student2.play_hooky

puts math_class.students.map(&:name)

book1 = Book.new('The Noob', 'John Doe')
book2 = Book.new('Harry Pot', 'Joker Rowling')
Rental.new('2020-10-21', book1, student1)
Rental.new('2020-12-21', book2, student2)
Rental.new('2020-11-21', book1, student2)
Rental.new('2020-09-21', book2, student1)

math_class.students.map { |student| puts "Student #{student.name} in the #{math_class.label} classroom" }
book1.rentals.map { |rental| puts "Book: #{rental.book.title} Date: #{rental.date}, Student: #{rental.person.name}" }
book2.rentals.map { |rental| puts "Book: #{rental.book.title} Date: #{rental.date}, Student: #{rental.person.name}" }
