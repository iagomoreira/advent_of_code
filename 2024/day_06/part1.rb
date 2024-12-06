require_relative '../../utils/bidimensional_array'

DIRECTIONS_TRANSITIONS = {
  :up => :right,
  :right => :down,
  :down => :left,
  :left => :up
}

input = ARGF.readlines.map {|line| line.strip.split('') }
matrix = BidimensionalArray.new(input)
VISITED_POSITIONS = []

def count_steps(element, direction)
  return 0 if element.nil?

  next_position = element.adjacent_element_in_direction(direction)

  return count_steps(element, DIRECTIONS_TRANSITIONS[direction]) if next_position == '#'

  if VISITED_POSITIONS.include?(element.position)
    return count_steps(next_position, direction)
  else
    VISITED_POSITIONS << element.position

    return 1 + count_steps(next_position, direction)
  end
end
steps_count = 0

matrix.each do |line|
  line.each do |char|
    if char == '^'
      steps_count += count_steps(char, :up)
    end
  end
end

puts VISITED_POSITIONS.size
puts steps_count
