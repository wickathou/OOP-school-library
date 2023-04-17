class Person
  attr_reader :id, :name, :age
  attr_writer :name, :age
  def initialize(id,age,name='Unknown',parent_permission=true)
    @id = id
    @name = name
    @age = age
  end

  private def of_age?
    return true if @age >= 18
    false
  end

  def can_use_services?
    return true if of_age? || @parent_permission
    false
  end
end
