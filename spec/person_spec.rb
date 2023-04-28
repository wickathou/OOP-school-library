describe Person do
  context 'create a person' do
    person = Person.new('Microverse', 27)

    it ' show age' do
      expect(person.age).to eq 27
    end

    it 'show name' do
      expect(person.name).to eq 'Microverse'
    end

    it 'when the person does not have parent permission' do
      person = Person.new('James', 16, parent_permission: false)
      expect(person.can_use_services?).to eq(false)
    end

    it 'when the person does not have parent permission but returns true if the person is above 18' do
      person = Person.new('James', 21, parent_permission: false)
      expect(person.can_use_services?).to eq(true)
    end

    it 'when the person  have parent permission' do
      person = Person.new('James', 26, parent_permission: true)
      expect(person.can_use_services?).to eq(true)
    end
  end
end