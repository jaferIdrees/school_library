require_relative '../classes/student'
require_relative '../classes/teacher'
require_relative '../classes/book'
require_relative '../classes/rental'

def choices
  {
    1 => 'List all books',
    2 => 'List all people',
    3 => 'Create a person',
    4 => 'Create a book',
    5 => 'Create a rental',
    6 => 'List all rentals for a person id',
    7 => 'Exit'
  }
end

# State class to store app's state
class State
  def initialize
    @books = []
    @people = []
  end

  def create_student
    print 'Age:'
    age = gets.chomp
    print 'Name:'
    name = gets.chomp
    print 'Has parent permission?[Y/N]:'
    permission = gets.chomp
    @people << Student.new(age, name, parent_permission: permission.upcase == 'Y')
    puts 'Student added successfully'
  end

  def create_teacher
    print 'Age:'
    age = gets.chomp
    print 'Name:'
    name = gets.chomp
    print 'Specialization:'
    specialization = gets.chomp
    @people << Teacher.new(specialization, name, age)
  end

  def create_book
    print 'Title:'
    title = gets.chomp
    print 'Author:'
    author = gets.chomp
    @books << Book.new(title, author)
    puts 'Book crteated successfully'
  end

  def list_people(indexed: false)
    @people.each_with_index do |person, index|
      print "#{index}) " if indexed
      print "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age:#{person.age}\n"
    end
    main_menu
  end

  def list_books(indexed: false)
    @books.each_with_index do |book, index|
      print "#{index}) " if indexed
      print "Title: #{book.title}, Author: #{book.author}\n"
    end
    main_menu
  end

  def create_rental
    if @people.size.zero? || @books.size.zero?
      return 'You didn\'t have any person and/or book added yet; rental cant be created!'
    end

    puts 'Select a book from the following list by number'
    list_books(indexed: true)
    book = gets.chomp

    puts 'Select a person from the following list by number'
    list_people(indexed: true)
    person = gets.chomp

    print 'Date:'
    date = gets.chomp
    Rental.new(date, @books[book.to_i], @people[person.to_i])

    'Rental created successfully'
  end

  def rental_list
    print 'ID of person'
    person_id = gets.chomp
    person = @people.select { |p| p.id == person_id.to_i }
    puts 'Rentals:'
    person[0].rentals.each do |rental|
      puts "Date: #{rental.date}, Book \"#{rental.book.title}\" by #{rental.book.author}"
    end
  end

  def create_person
    print 'Do you want to create a student (1) ot a teacher (2)?[Input a number]:'
    person_choice = gets.chomp
    person_choice == '1' ? create_student : create_teacher
  end

  # Method to handle user choice
  def handle_choice(choice)
    case choice
    when 'List all books'
      list_books
    when 'List all people'
      list_people
    when 'Create a person'
      create_person
      main_menu
    when 'Create a book'
      create_book
      main_menu
    when 'Create a rental'
      puts create_rental
      main_menu
    when 'List all rentals for a person id'
      rental_list
      main_menu
    else
      exit(0)
    end
  end

  def main_menu
    puts ''
    puts 'Please choose an option by entering a number:'
    choices.each { |key, value| puts "#{key}:#{value}" }
    print 'Please enter a number:'
    choice = gets.chomp
    handle_choice(choices[choice.to_i])
    puts choices[choice.to_i]
  end

  def run
    main_menu
  end
end

# Main method
def main
  puts 'Welcome to School library App!'
  app = State.new
  app.run
end

main
