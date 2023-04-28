require_relative 'spec_utils'

describe '#SaveBookDecorator' do
  it 'creates a SaveBookDecorator' do
    books = []
    save_books_decorator = SaveBookDecorator.new(books)
    expect(save_books_decorator).to be_instance_of(SaveBookDecorator)
  end

  it 'creates a hash using the hash_generator method' do
    books = []
    book_generator(books)
    save_books_decorator = SaveBookDecorator.new(books)
    save_books_decorator.hash_generator
    expect(save_books_decorator.hash).to be_instance_of(Hash)
    id_compare = 0
    save_books_decorator.hash.each do |entry|
      expect(entry).to be_instance_of(Array)
      expect(entry[0]).to be_instance_of(Book)
      expect(entry[1][:id]).to eq id_compare
      expect(entry[1][:title]).to eq '1984'
      expect(entry[1][:author]).to eq 'George Orwell'
      id_compare += 1
    end
  end

  it 'creates a json file storing books' do
    books = []
    book_generator(books)
    SaveBookDecorator.new(books).save_routine
    expect(File.exist?('./data/books.json')).to be true
  end

  it 'Loads a json file with books data' do
    books = []
    book_generator(books)
    SaveBookDecorator.new(books).save_routine
    loaded_books = []
    SaveBookDecorator.new(loaded_books).load_data
    expect(loaded_books.length).to eq 5
  end
end
