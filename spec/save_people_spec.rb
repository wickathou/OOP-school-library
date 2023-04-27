require_relative 'spec_utils'

describe "#SavePeopleDecorator" do

    it "creates a SavePeopleDecorator" do
      people = []
      save_people_decorator = SavePeopleDecorator.new(people)
      expect(save_people_decorator).to be_instance_of(SavePeopleDecorator)
    end

    it "creates a hash using the hash_generator method" do
      people = []
      people_generator(people)
      save_people_decorator = SavePeopleDecorator.new(people)
      save_people_decorator.hash_generator
      expect(save_people_decorator.hash).to be_instance_of(Hash)
      id_compare = 0
      save_people_decorator.hash.each {|entry|
        expect(entry).to be_instance_of(Array)
        expect(entry[0]).to be_instance_of(Person)
        expect(entry[1][:id]).to eq id_compare
        expect(entry[1][:age]).to eq 17
        expect(entry[1][:name]).to eq 'John Doe'
        id_compare += 1
      }
    end

    it "creates a json file storing people" do
      people = []
      people_generator(people)
      SavePeopleDecorator.new(people).save_routine
      expect(File.exist?('./data/people.json')).to be true
    end

    it "Loads a json file with people data" do
      people = []
      people_generator(people)
      SavePeopleDecorator.new(people).save_routine
      loaded_people = []
      SavePeopleDecorator.new(loaded_people).load_data
      expect(loaded_people.length).to eq 5
    end
end
