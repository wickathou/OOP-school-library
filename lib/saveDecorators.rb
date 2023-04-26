require 'json'



class SaveDecorator
  attr_accessor :instances, :hash
  def initialize(instanceArray)
    @instances = instanceArray
    @hash = {}
  end
  
  def to_json
    JSON.pretty_generate (@hash)
  end

  def hash_generator
    raise NotImplementedError, 'method not implemented yet'
  end

  def save_routine
    self.hash_generator
    self.save_json
  end
  
  def save_json
    File.write('rentals.json', self.to_json)
  end
end

class SaveRentalDecorator < SaveDecorator
  
  def hash_generator
    @instances.each {|instance|
      @hash[instance] = {
        :date => instance.date,
        :book => instance.book.title,
        :person => instance.person.name
      }
    }
  end

end
