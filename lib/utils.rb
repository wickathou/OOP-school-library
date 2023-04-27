module Utilities
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

  def id_generator(arr)
    arr.length
  end

  def input_prompt(arr)
    (0..arr.length - 1).each do |i|
      puts("#{arr.at(i)}:")
      arr[i] = gets.chomp
    end
    arr
  end

  def permission_checker
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
    parent_permission
  end
end
