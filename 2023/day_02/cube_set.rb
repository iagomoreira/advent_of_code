class CubeSet
  attr_accessor :blue, :red, :green

  MAX_CUBES_BY_COLOR = {
    :red => 12,
    :green => 13,
    :blue => 14
  }

  def initialize(set)
    @blue = 0
    @green = 0
    @red = 0

    cube_qty = set.split(", ")
    cube_qty.each do |c|
      quantity, color = c.split
      instance_variable_set("@#{color}", quantity.to_i)
    end
  end

  def valid?
    MAX_CUBES_BY_COLOR.all? do |color, quantity|
      instance_variable_get("@#{color}").to_i <= quantity
    end
  end
end
