require_relative 'spec_utils'

describe "#Rental" do
    it "creates a rental instance for a Person" do
      book = Book.new(1, '1984', 'George Orwell')
      person = Person.new(1, 17, 'John Doe', true)
      rental = Rental.new(1, book, person)
        expect(rental).to be_instance_of(Rental)
        expect(rental.person).to eq person
        expect(rental.book).to eq book
    end

    it "creates a rental instance for a student" do
      book = Book.new(1, '1984', 'George Orwell')
      student = Student.new(1, 17, 'John Doe', true)
      rental = Rental.new(1, book, student)
        expect(rental).to be_instance_of(Rental)
        expect(rental.person).to eq student
        expect(rental.book).to eq book
    end

    it "creates a rental instance for a teacher" do
      book = Book.new(1, '1984', 'George Orwell')
      teacher = Teacher.new(1, 17, 'John Doe', 'Math')
      rental = Rental.new(1, book, teacher)
        expect(rental).to be_instance_of(Rental)
        expect(rental.person).to eq teacher
        expect(rental.book).to eq book
    end
end