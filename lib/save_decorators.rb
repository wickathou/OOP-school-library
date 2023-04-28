require 'json'

class SaveDecorator
  attr_accessor :instances, :hash

  def initialize(instances)
    @instances = instances
    @hash = {}
  end

  def to_json(*_args)
    JSON.pretty_generate(@hash)
  end

  def hash_generator
    raise NotImplementedError, 'method not implemented yet'
  end

  def save_routine
    hash_generator
    save_json
  end

  def save_json
    raise NotImplementedError, 'method not implemented yet'
  end
end

class SaveRentalDecorator < SaveDecorator
  def hash_generator
    @instances.each do |instance|
      @hash[instance] = {
        date: instance.date,
        book_id: instance.book.id,
        book: instance.book.title,
        person_id: instance.person.id,
        person: instance.person.name
      }
    end
  end

  def save_json
    File.write('./data/rentals.json', to_json)
  end

  def load_data(books, people)
    return unless File.exist?('./data/rentals.json')

    file = File.read('./data/rentals.json')
    saved_rentals = JSON.parse(file)
    saved_rentals.each do |rental|
      @instances << Rental.new(rental[1]['date'], books[rental[1]['book_id']], people[rental[1]['person_id']])
    end
    puts 'Rental history loaded from file'
  end
end

class SaveBookDecorator < SaveDecorator
  def hash_generator
    @instances.each do |instance|
      @hash[instance] = {
        id: instance.id,
        title: instance.title,
        author: instance.author
      }
    end
  end

  def save_json
    File.write('./data/books.json', to_json)
  end

  def load_data
    return unless File.exist?('./data/books.json')

    file = File.read('./data/books.json')
    saved_books = JSON.parse(file)
    saved_books.each { |book| @instances << Book.new(book[1]['id'], book[1]['title'], book[1]['author']) }
    puts 'Books loaded from file'
  end
end

class SavePeopleDecorator < SaveDecorator
  def hash_generator
    @instances.each do |instance|
      @hash[instance] = {
        id: instance.id,
        name: instance.name,
        age: instance.age,
        type: instance.class,
        type_specific: type_specific_generator(instance)
      }
    end
  end

  def type_specific_generator(instance)
    case instance.class.to_s
    when 'Teacher'
      teacher_type(instance)
    when 'Student'
      student_type(instance)
    when 'Person'
      {}
    else
      raise NotImplementedError, 'Instance class not implemented yet'
    end
  end

  def teacher_type(instance)
    {
      specialization: instance.specialization
    }
  end

  def student_type(instance)
    {
      parent_permission: instance.parent_permission,
      classroom: instance.classroom
    }
  end

  def save_json
    File.write('./data/people.json', to_json)
  end

  def load_data
    return unless File.exist?('./data/people.json')

    file = File.read('./data/people.json')
    saved_people = JSON.parse(file)
    saved_people.each do |people|
      person = people[1]
      case person['type']
      when 'Teacher'
        @instances << Teacher.new(person['id'], person['age'], person['name'],
                                  person['type_specific']['specialization'])
      when 'Student'
        @instances << Student.new(person['id'], person['age'], person['name'],
                                  person['type_specific']['parent_permission'], person['type_specific']['classroom'])
      when 'Person'
        @instances << Person.new(person['id'], person['age'], person['name'])
      else
        raise NotImplementedError, 'Instance class not valid'
      end
    end
    puts 'People loaded from file'
  end
end
