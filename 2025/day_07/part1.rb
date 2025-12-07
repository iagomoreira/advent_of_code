require_relative '../../utils/bidimensional_array'

matrix = BidimensionalArray.new(ARGF.readlines(chomp: true).map(&:chars))
starting_index = matrix.first.size/2
splitter_positions = Set.new

def move_downward(element, splitter_positions)
  new_element = element.adjacent_element_in_direction(:down)

  if new_element == nil
    return element
  elsif new_element.value == '^'
    return new_element if splitter_positions.include?(new_element.position)
    splitter_positions << new_element.position
    left_element = new_element.adjacent_element_in_direction(:left)
    right_element = new_element.adjacent_element_in_direction(:right)
    move_downward(left_element, splitter_positions)
    move_downward(right_element, splitter_positions)
  else
    return move_downward(new_element, splitter_positions)
  end
end

move_downward(matrix[0][starting_index], splitter_positions)

puts splitter_positions.size
