require './person.rb'

class Teacher < Person

  def initialize(specialization, age, name, parent_permission)
    super(age, name, parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end

t = Student.new(18, 'math')
puts t
