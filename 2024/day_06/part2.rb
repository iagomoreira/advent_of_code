require_relative '../../utils/bidimensional_array'

DIRECTIONS_TRANSITIONS = {
  :up => :right,
  :right => :down,
  :down => :left,
  :left => :up
}

input = ARGF.readlines.map {|line| line.strip.split('') }
grid = BidimensionalArray.new(input)
VISITED_POSITIONS = {}

def count_steps(element, direction, visited_positions)
  return visited_positions if element.nil?

  next_position = element.adjacent_element_in_direction(direction)
  current_position_id = element.position

  if next_position == '#'
    return count_steps(element, DIRECTIONS_TRANSITIONS[direction], visited_positions)
  end

  if visited_positions[current_position_id]
    raise StandardError if visited_positions[current_position_id].include?(direction)
    return count_steps(next_position, direction, visited_positions)
  else
    visited_positions[current_position_id] ||= []
    visited_positions[current_position_id] += [direction]

    return count_steps(next_position, direction, visited_positions)
  end
end

visited_positions = {}
grid.each do |line|
  line.each do |char|
    if char == '^'
      visited_positions = count_steps(char, :up, visited_positions)
    end
  end
end

puts visited_positions.size

loops_found = 0

visited_positions.each do |position, _|
  new_grid = grid.dup
  i, j = position
  old_element = grid[i][j]
  if old_element.value != '^'
    element = BidimensionalArray::Element.new('#', position, new_grid)
    new_grid[i][j] = element
  end

  new_grid.each do |line|
    line.each do |char|
      if char == '^'
        begin
          count_steps(char, :up, {})
        rescue StandardError
          loops_found += 1
        end
      end
    end
  end
end

puts loops_found
