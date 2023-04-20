class Nameable
  def correct_name
    raise NotImplementedError, 'method not implemented yet'
  end
end

class Person < Nameable
  attr_accessor :name, :age
  attr_reader :id

  def initialize(id, age, name = 'Unknown', parent_permission = nil)
    super()
    @id = id
    @name = name
    @age = age
    @parent_permission = if parent_permission.nil?
                           true
                         else
                           parent_permission
                         end
  end

  def can_use_services?
    return true if of_age? || @parent_permission

    false
  end

  def correct_name
    @name
  end

  private

  def of_age?
    return true if @age >= 18

    false
  end
end

class Decorator < Nameable
  def initialize(nameable)
    super()
    @nameable = nameable
  end

  def correct_name
    @nameable.correct_name
  end
end

class CapitalizeDecorator < Decorator
  def correct_name
    super.capitalize
  end
end

class TrimmerDecorator < Decorator
  def correct_name
    super.slice(0, 10)
  end
end
