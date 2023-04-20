require_relative 'person'

class Student < Person
  def initialize(id, age, name, parent_permission, classroom)
    super(id, age, name, parent_permission)
    @classroom = classroom
    @classroom.students << self
    @rentals = []
  end

  def play_hooky
    '¯\(ツ)/¯'
  end
end

puts student1 = Student.new(1, 22, 'Mark', true, 'Math')
puts student1.can_use_services?
puts student1.play_hooky

puts student2 = Student.new(2, 15, 'John', true, 'Math')
puts student2.can_use_services?
puts student2.play_hooky
