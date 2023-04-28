require_relative 'spec_utils'

describe Book do
  context 'create a book' do
    book = Book.new 1, 'Purple_Hibiscus', 'Chiamanda'

    it 'show the title' do
      expect(book.title).to eq 'Purple_Hibiscus'
    end

    it 'show the author' do
      expect(book.author).to eq 'Chiamanda'
    end
  end
end
