require_relative 'spec_utils'

describe "#SaveRentalDecorator" do

    it "creates a SaveRentalDecorator" do
      rentals = []
      rental_generator(rentals, instance_creator[0], instance_creator[1])
      save_rental_decorator = SaveRentalDecorator.new(rentals)
      expect(save_rental_decorator).to be_instance_of(SaveRentalDecorator)
    end

    it "creates a hash using the hash_generator method" do
      rentals = []
      rental_generator(rentals, instance_creator[0], instance_creator[1])
      save_rental_decorator = SaveRentalDecorator.new(rentals)
      save_rental_decorator.hash_generator
      expect(save_rental_decorator.hash).to be_instance_of(Hash)
      save_rental_decorator.hash.each {|entry|
        expect(entry).to be_instance_of(Array)
        expect(entry[0]).to be_instance_of(Rental)
        expect(entry[1][:book_id]).to eq 0
        expect(entry[1][:person_id]).to eq 0
      }
    end

    it "creates a json file storing rentals" do
      rentals = []
      rental_generator(rentals, instance_creator[0], instance_creator[1])
      SaveRentalDecorator.new(rentals).save_routine
      expect(File.exist?('./data/rentals.json')).to be true
    end

    it "Loads a json file with rental data" do
      books = []
      people = []
      rentals = []
      books << instance_creator[0]
      people << instance_creator[1]
      rental_generator(rentals, books[0], people[0])
      SaveRentalDecorator.new(rentals).save_routine
      loaded_rentals = []
      SaveRentalDecorator.new(loaded_rentals).load_data(books, people)
      expect(loaded_rentals.length).to eq 5
    end
end
