# id, age, name, parent_permission, classroom = nil
describe Student do
  context 'create a student' do
    student = Student.new(1, 48, 'Arike', parent_permission: true)

    it 'show name' do
      expect(student.name).to eq 'Arike'
    end

    # it 'show classroom' do
    #   expect(student.classroom).to eq nil
    # end

    it 'show age' do
      expect(student.age).to eq 48
    end
  end
end
