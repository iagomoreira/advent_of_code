require 'delegate'

class BidimensionalArray < SimpleDelegator

  class Element < SimpleDelegator
    VALID_POSITIONS = [:up, :down, :left, :right, :up_left, :up_right, :down_left, :down_right]
    attr_reader :value, :position

    def initialize(value, position, parent)
      super(value)
      @value = value
      @position = position
      @parent_bidimensional_array = parent
    end

    def adjacent_elements
      VALID_POSITIONS.map {|direction| adjacent_element_in_direction(direction) }
    end

    def adjacent_element_in_direction(direction)
      adjacent_position = adjacent_position_in_direction(direction)

      @parent_bidimensional_array.dig(*adjacent_position) unless adjacent_position.any?(&:negative?)
    end

    def adjacent_positions
      VALID_POSITIONS.map {|direction| adjacent_position_in_direction(direction) }
    end

    def adjacent_position_in_direction(direction)
      i, j = @position

      case direction
      when :up
        [i-1, j]
      when :down
        [i+1, j]
      when :left
        [i, j-1]
      when :right
        [i, j+1]
      when :up_left
        [i-1, j-1]
      when :up_right
        [i-1, j+1]
      when :down_left
        [i+1, j-1]
      when :down_right
        [i+1, j+1]
      end
    end
  end

  def initialize(array)
    @array = array.each_with_index.map do |line, i|
      line.each_with_index.map {|element, j| Element.new(element, [i,j], self) }
    end

    super(@array)
  end
end
