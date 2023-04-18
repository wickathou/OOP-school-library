require_relative 'person'

class Teacher < Person
  def initialize(id, age, name, parent_permission, specialization)
    super(id, age, name, parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end

puts teacher = Teacher.new(1, 22, 'Mark', true, 'Math')
puts teacher.can_use_services?
