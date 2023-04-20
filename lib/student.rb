require_relative 'person'

class Student < Person
  attr_accessor :rentals, :classroom

  def initialize(id, age, name, parent_permission, classroom = nil)
    super(id, age, name, parent_permission)
    unless classroom.nil?
      @classroom = classroom
      @classroom.students << self
    end
    @rentals = []
    notify
  end

  def notify
    puts "Student #{@name} enrolled"
  end

  def play_hooky
    '¯\(ツ)/¯'
  end
end
