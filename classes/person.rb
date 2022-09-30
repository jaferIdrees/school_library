require_relative 'nameable'

# Person class
class Person < Nameable
  attr_accessor :name, :age
  attr_reader :id, :rentals

  def initialize(age, name = 'unknown', parent_permission = true) # rubocop:disable Style/OptionalBooleanParameter
    super()
    @id = Random.rand(1...1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  def correct_name
    @name
  end

  def can_use_services?
    is_of_age? || @parent_permission
  end

  def add_rental(rental)
    @rentals << rental
    rental.person = self
  end

  private

  def is_of_age? # rubocop:disable Naming/PredicateName
    @age >= 18
  end
end
