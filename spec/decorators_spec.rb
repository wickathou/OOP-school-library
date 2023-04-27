require_relative 'spec_utils'

describe "#Decorators" do
    it "creates a decorator instance from a Person instance" do
      person = Person.new(1, 17, 'John', true)
      person_decorated = Decorator.new(person)
        expect(person_decorated).to be_instance_of(Decorator)
    end
    
    it "creates a CapitalizeDecorator instance from a Person instance" do
      person = Person.new(1, 17, 'mike', true)
      person_decorated = CapitalizeDecorator.new(person)
        expect(person_decorated).to be_instance_of(CapitalizeDecorator)
        expect(person_decorated.correct_name).to eq 'Mike'
    end

    it "creates a TrimmerDecorator instance from a Person instance" do
      person = Person.new(1, 17, 'Galactimonium', true)
      person_decorated = TrimmerDecorator.new(person)
        expect(person_decorated).to be_instance_of(TrimmerDecorator)
        expect(person_decorated.correct_name).to eq 'Galactimon'
    end
end