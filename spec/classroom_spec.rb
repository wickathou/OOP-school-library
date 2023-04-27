require_relative 'spec_utils'

describe "#Classroom" do
    it "creates a classroom instance" do
      math_class = Classroom.new('Math')
        expect(math_class).to be_instance_of(Classroom)
        expect(math_class.label).to eq 'Math'
    end

    it "assigns students to a classroom" do
      math_class = Classroom.new('Math')
      student = Student.new(1, 17, 'John Doe', true, math_class)
      expect(student.classroom).to eq math_class
      expect(math_class.students).to include student
    end

end