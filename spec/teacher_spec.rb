describe Teacher do
  context 'create a teacher' do
    teacher = Teacher.new(1, 33, 'John', 'Ruby')

    it 'check the age' do
      expect(teacher.age).to eq 33
    end

    it 'check the name' do
      expect(teacher.name).to eq 'John'
    end
  end
end
