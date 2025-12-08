class JunctionBox
  attr_reader :x, :y, :z
  attr_accessor :circuit

  def initialize(coordinates)
    @x, @y, @z = coordinates
    @circuit = nil
  end

  def id
    [@x, @y, @z].join(',')
  end

  def shortest_distance_to(other_box)
    Math.sqrt((@x - other_box.x)**2 + (@y - other_box.y)**2 + (@z - other_box.z)**2)
  end
end
