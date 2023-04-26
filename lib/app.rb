require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rentals'
require_relative 'classroom'
require_relative 'save_decorators'
require_relative 'person'

class App
  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def run
    puts 'Welcome to School Library App!'
    app_loop
  end

  def list_books
    if File.exist?('./data/books.json')
      file = File.read('./data/books.json')
      save = JSON.parse(file)
      save.each { |book| puts "Title: #{book['title']}, Author: #{book['author']}" }
    else
      @books.each { |book| puts "#{book.title} by #{book.author}" }
    end
  end

  def list_people
    save = []

    if File.exist?('./data/people.json')
      file = File.read('./data/people.json')
      save = JSON.parse(file)
      save.each { |person| puts "#{person['name']}-#{person['age']}" }
    end

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
    id = @people.length + 1
    prompt_arr = input_prompt(%w[name age])
    puts 'Has parent permission? [Y/N]?'
    permission = gets.chomp
    if permission.match?(/y/i)
      parent_permission = true
    elsif permission.match?(/n/i)
      parent_permission = false
    else
      puts 'That is not a valid input'
      return
    end
    student = Student.new(id, prompt_arr[1], prompt_arr[0], parent_permission)
    add_person(student)
    puts 'Student created successfully'
  end

  def create_teacher
    id = @people.length + 1
    prompt_arr = input_prompt(%w[name age specialization])
    teacher = Teacher.new(id, prompt_arr[1], prompt_arr[0], prompt_arr[2])
    add_person(teacher)
    puts 'Teacher created successfully'
  end

  def create_book
    puts 'Title:'
    title = gets.chomp
    puts 'Author:'
    author = gets.chomp
    book = Book.new(title, author)
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

  def add_person(person)
    @people << person
  end

  def input_prompt(arr)
    (0..arr.length - 1).each do |i|
      puts("#{arr.at(i)}:")
      arr[i] = gets.chomp
    end
    arr
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

  def interface_menu
    puts 'Please choose an option by entering a number:'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'
  end

  def save_rentals
    SaveRentalDecorator.new(@rentals).save_routine
    SaveBookDecorator.new(@books).save_routine
    SavePersonDecorator.new(@people).save_routine

  end

  def app_exit
    save_rentals
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
