require_relative 'base_decorator'
require_relative 'person'
require_relative 'trimmer_decorator'

# Capitalize decorator
class Capitalize < Decorator
  def correct_name
    @nameable.correct_name.capitalize
  end
end
