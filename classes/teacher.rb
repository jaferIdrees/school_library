require_relative 'person'

class Teacher < Person
  def initialize(specialization, age, name = 'unknown', id: nil, parent_permission: true)
    super(age, name, parent_permission, id: id)
    @specialization = specialization
  end

  def as_hash
    {
      'id' => @id,
      'name' => @name,
      'age' => @age,
      'parent_permission' => @parent_permission,
      'specialization' => @specialization
    }
  end

  def can_use_services?
    true
  end
end
