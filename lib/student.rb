require_relative 'person'

class Student < Person
  attr_accessor :rentals

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
