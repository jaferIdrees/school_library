require_relative '../classes/person'
require_relative '../classes/capitalize_decorator'
require_relative '../classes/trimmer_decorator'

person = Person.new(22, 'maximilianus')
puts "Original name: #{person.correct_name}"
capitalized_person = Capitalize.new(person)
puts "Capitalized name: #{capitalized_person.correct_name}"
capitalized_trimmed_person = Trimmer.new(capitalized_person)
puts "Capitalized Trimmed name: #{capitalized_trimmed_person.correct_name}"
