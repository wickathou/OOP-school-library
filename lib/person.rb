require_relative 'nameable'
require_relative 'decorators'
require 'json'

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
