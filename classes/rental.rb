# Rental class
class Rental
  attr_accessor :book, :date, :person

  def initialize(date, book, person)
    @date = date
    @book = book
    @person = person
    book.rentals << self
    person.add_rental(self)
  end
end
