require 'json'
require_relative 'rentals'
require_relative 'book'

def load_data
  if File.exist?('./data/books.json')
    file = File.read('./data/books.json')
    save = JSON.parse(file)
    save.each { |book| puts "Title: #{book["title"]}, Author: #{book["author"]}"}
  else
    @books.each { |book| puts "#{book.title} by #{book.author}" }
  end
end

def load_data_books
  file = File.read('./data/books.json')
  saved_books = JSON.parse(file)
  loaded_books = []
  saved_books.each { |book| loaded_books << Book.new(book[1]["id"], book[1]["title"], book[1]["author"])}
end

load_data_books

def load_data
  file = File.read('./data/rentals.json')
  save = JSON.parse(file)
  puts save.class
  # save.each { |rental| puts rental[1]["date"]}
  save.each { |rental| Rental.new(rental[1]["date"], rental[1]["book"], rental[1]["date"])}
end

# load_data

# def initialize(date, book, person)
