require 'fileutils'
require 'json'
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
    @rentals = []
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
    @people << Teacher.new(specialization, age, name)
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
    main_menu unless indexed
  end

  def list_books(indexed: false)
    @books.each_with_index do |book, index|
      print "#{index}) " if indexed
      print "Title: #{book.title}, Author: #{book.author}\n"
    end
    main_menu unless indexed
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
    @rentals << Rental.new(date, @books[book.to_i], @people[person.to_i])

    'Rental created successfully'
  end

  def rental_list
    print 'ID of person'
    person_id = gets.chomp
    person = @people.select { |p| p.id == person_id.to_i }
    if person.size.zero?
      puts 'Person not found'
      return
    end
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

  def save_data
    FileUtils.mkdir_p('./app_data/')
    FileUtils.cd('./app_data/') do
      FileUtils.rm_f('books.json')
      FileUtils.rm_f('people.json')
      FileUtils.rm_f('rentals.json')
      FileUtils.touch('books.json')
      FileUtils.touch('people.json')
      FileUtils.touch('rentals.json')

      # generate json object
      books_json = []
      @books.each { |book| books_json << JSON.generate(book.as_hash) }
      people_json = []
      @people.each { |person| people_json << JSON.generate(person.as_hash) }
      rentals_json = []
      @rentals.each { |rental| rentals_json << JSON.generate(rental.as_hash) }

      # write data to their respective files
      File.write('books.json', books_json)
      File.write('people.json', people_json)
      File.write('rentals.json', rentals_json)
    end
  end

  def read_data
    if File.exists?('./app_data/books.json')
      books = []
      File.foreach('./app_data/books.json') { |book| books << JSON.parse(book)}
      books.each { |book| book.each {|book| @books << Book.new(JSON.parse(book)['Title'], JSON.parse(book)['Author'])}}
    end
    
    if File.exists?('./app_data/people.json')
      puts 'read people'
      people = []
      File.foreach('./app_data/people.json') { |line| people << JSON.parse(line)}
    
      people.each do |people| people.each do
        |person|
        if !person['classroom'].nil?
          @people << Student.new(JSON.parse(person)['age'], JSON.parse(person)['name'], JSON.parse(person)['parent_permission'], id: JSON.parse(person)['id'])
        else
          @people << Teacher.new(JSON.parse(person)['specialization'], JSON.parse(person)['age'], JSON.parse(person)['name'], parent_permission: JSON.parse(person)['parent_permission'], id: JSON.parse(person)['id'])
        end
      end
      end
    end

    if File.exists?('./app_data/rentals.json')
        rentals = JSON.parse(File.read('./app_data/rentals.json'))
        rentals.each do
          |rental|
          r = JSON.parse(rental)
          person = @people.select { |person| person.id.to_i == r['person']['id'].to_i}
          puts person[0]

          b = r['book']['Title'] + r['book']['Author']
          book = @books.select { |book| (book.title + book.author) == b}
          puts book[0]
          puts r['date']
          @rentals << Rental.new(r['date'], book[0], person[0])

        end
    end
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
    when 'Create a book'
      create_book
    when 'Create a rental'
      puts create_rental
    when 'List all rentals for a person id'
      rental_list
    when 'Exit'
      save_data
    else
      puts 'Invalid choice, please try again:'
    end
  end

  def main_menu
    loop do
      puts ''
      puts 'Please choose an option by entering a number:'
      choices.each { |key, value| puts "#{key}:#{value}" }
      print 'Please enter a number:'
      choice = gets.chomp
      handle_choice(choices[choice.to_i])
      break if choice == '7'
      puts choices[choice.to_i]
    end
  end

  def run
    read_data
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
