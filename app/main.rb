# frozen_string_literal: true

# $choices = %w(
#   List\ all\ books
#   List\ all\ people
#   Create\ a\ person
#   Create\ a\ book
#   Create\ a\ rental
#   List\ all\ rentals\ for\ a\ person\ id
#   Exit)
class State
  def initialize
    @books = []
    @students = []
    @teachers = []
  end


end
def choices
  choices = {
    1 => 'List all books',
    2 => 'List all people',
    3 => 'Create a person',
    4 => 'Create a book',
    5 => 'Create a rental',
    6 => 'List all rentals for a person id',
    7 => 'Exit'
  }
end

# Method to handle user choice
def handle_choice(choice)
  case choice
  when 1
  when 2
  when 3
    print 'Do you want to create a student (1) ot a teacher (2)?[Input a number]:'
    person_choice = gets.chomp
    state.create_person(person_choice)
  when 4
  when 5
  when 6
  when 7
  else
    puts 'Invalid choice'
    main
  end
end
# Main method
def main

  state if state.nil?
  puts 'Welcome to School library App!'
  puts ''
  puts 'Please choose an option by entering a number:'
  choices.each { |key, value| puts "#{key}:#{value}"}
  print 'Please enter a number:'
  choice = gets.chomp
  handle_choice(choice.to_i)
  puts choices[choice.to_i]
end

main
