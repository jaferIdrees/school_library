require_relative 'nameable'

class Decorator < Nameable
  attr_accessor :nameable

  # @param [nameable] nameable
  def initialize(nameable_type)
    super()
    @nameable = nameable_type
  end

  def correct_name
    @nameable.correct_name
  end
end
