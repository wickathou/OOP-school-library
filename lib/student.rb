require_relative 'person'

class Student < Person
  attr_accessor :classroom

  def initialize(id, age, name, parent_permission, classroom = nil)
    super(id, age, name, parent_permission)
    unless classroom.nil? || classroom == 'null'
      @classroom = classroom
      @classroom.students << self
    end
    notify
  end

  def notify
    puts "Student #{@name} enrolled"
  end

  def play_hooky
    '¯\(ツ)/¯'
  end
end
