require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rentals'
require_relative 'classroom'
require_relative 'save_decorators'
require_relative 'person'
require_relative 'utils'

class App
  include Utilities
  def initialize
    @books = []
    @people = []
    @rentals = []
    load_data
  end

  def run
    app_loop
  end

  def list_books
    @books.each { |book| puts "#{book.title} by #{book.author}" }
  end

  def list_people
    @people.each { |person| puts "#{person.name} - #{person.age}" }
  end

  def list_rentals_person
    puts 'Select a person from the following list by number (not id)'
    @people.each_with_index { |person, index| puts "#{index}) #{person.name}" }
    person_index = gets.chomp.to_i
    show_rentals_person(person_index)
  end

  def show_rentals_person(person_index)
    puts "#{@people[person_index].name} has rented the following books:"
    @people[person_index].rentals.map do |rental|
      puts "Date: #{rental.date}, Book: #{rental.book.title} by #{rental.book.author}"
    end
  end

  def create_person
    puts 'Do you want to create a student (1) or a teacher (2)? [Input the number]'
    option = gets.chomp

    case option
    when '1'
      create_student
    when '2'
      create_teacher
    else
      puts 'That is not a valid input'
      nil
    end
  end

  def create_student
    id = id_generator(@people)
    prompt_arr = input_prompt(%w[name age])
    parent_permission = permission_checker
    student = Student.new(id, prompt_arr[1], prompt_arr[0], parent_permission)
    add_person(student)
    puts 'Student created successfully'
  end

  def create_teacher
    id = id_generator(@people)
    prompt_arr = input_prompt(%w[name age specialization])
    teacher = Teacher.new(id, prompt_arr[1], prompt_arr[0], prompt_arr[2])
    add_person(teacher)
    puts 'Teacher created successfully'
  end

  def create_book
    id = id_generator(@books)
    puts 'Title:'
    title = gets.chomp
    puts 'Author:'
    author = gets.chomp
    book = Book.new(id, title, author)
    add_book(book)
    puts 'Book has been created successfully'
  end

  def create_rental
    puts 'Select a book from the following list by number'
    @books.each_with_index { |book, index| puts "#{index}) #{book.title}" }
    book_index = gets.chomp.to_i

    puts 'Select a person from the following list by number (not id)'
    @people.each_with_index { |person, index| puts "#{index}) #{person.name}" }
    person_index = gets.chomp.to_i

    puts 'Date:'
    date = gets.chomp

    rental = Rental.new(date, @books[book_index], @people[person_index])
    add_rental(rental)
  end

  private

  def load_data
    SaveBookDecorator.new(@books).load_data
    SavePeopleDecorator.new(@people).load_data
    SaveRentalDecorator.new(@rentals).load_data(@books, @people)
  end

  def add_person(person)
    @people << person
  end

  def add_book(book)
    @books << book
  end

  def add_rental(rental)
    @rentals << rental
  end

  def option_selector(option)
    case option
    when '1'
      list_books
    when '2'
      list_people
    when '3'
      create_person
    when '4'
      create_book
    when '5'
      create_rental
    when '6'
      list_rentals_person
    else
      puts 'That is not a valid input'
    end
  end

  def save_data
    SaveRentalDecorator.new(@rentals).save_routine
    SaveBookDecorator.new(@books).save_routine
    SavePeopleDecorator.new(@people).save_routine
  end

  def app_exit
    save_data
    puts 'Thank you for using the Library App!'
  end

  def app_loop
    loop do
      interface_menu
      option = gets.chomp
      if option == '7'
        app_exit
        break
      end
      option_selector(option)
    end
  end
end
