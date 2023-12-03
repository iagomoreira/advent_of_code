require_relative 'cube_set'

class Game
  attr_reader :id, :sets

  def initialize(id, sets)
    @id = id.to_i
    @sets = sets.split(";").map {|set| CubeSet.new(set)}
  end

  def valid?
    @sets.all?(&:valid?)
  end

  def cube_set_power
    [
      sets.map(&:blue).max,
      sets.map(&:red).max,
      sets.map(&:green).max
    ].reduce(:*)
  end
end
