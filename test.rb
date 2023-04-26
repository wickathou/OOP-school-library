require 'json'

class Person
  attr_accessor :name, :age, :gender

  def initialize(name,age,gender)
    @name = name
    @age = age
    @gender = gender
  end

  def to_json
    JSON.dump ({
      :name => @name,
      :age => @age,
      :gender => @gender
    })
  end

  def self.from_json(string)
    data = JSON.load string
    self.new(data['name'], data['age'], data['gender'])
  end
end

person = Person.new('name',12,'something')

puts person.to_json