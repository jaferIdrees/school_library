require_relative 'classes/student'
require_relative 'classes/teacher'

# State class to store app's state
class State

  def initialize
    @books = []
    @people = []
  end

  def choices
    @choices = {
      1 => 'List all books',
      2 => 'List all people',
      3 => 'Create a person',
      4 => 'Create a book',
      5 => 'Create a rental',
      6 => 'List all rentals for a person id',
      7 => 'Exit'
    }
  end

  def create_student
    print 'Age:'
    age = gets.chomp
    print 'Name:'
    name = gets.chomp
    print 'Has parent permission?[Y/N]:'
    permission = gets.chomp
    @people << Student.new(_, name, age, permission == Y)
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
    
  end

  # Method to handle user choice
  def handle_choice(choice)
    case choice
    when 1
    when 'List all people'
      @people.each { |perosn| }
    when 'Create a person'
      print 'Do you want to create a student (1) ot a teacher (2)?[Input a number]:'
      person_choice = gets.chomp
      person_choice == 1 ? state.create_student : state.create_teacher
    when 'Create a book'
      create_book
    when 5
    when 6
    when 7
    else
      puts 'Invalid choice'
      main_menu
    end
  end

  def main_menu
    puts 'Welcome to School library App!'
    puts ''
    puts 'Please choose an option by entering a number:'
    choices.each { |key, value| puts "#{key}:#{value}" }
    print 'Please enter a number:'
    choice = gets.chomp
    handle_choice(choice.to_i)
    puts choices[choice.to_i]
  end

  def run
    main_menu
  end
end

# Main method
def main
  app = State.new
  app.run
end

main
