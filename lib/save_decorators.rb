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
        book: instance.book.title,
        person: instance.person.name
      }
    end
  end

  def save_json
    File.write('./data/rentals.json', to_json)
  end
end
