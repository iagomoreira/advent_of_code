require_relative '../../utils/bidimensional_array'

DIRECTIONS_TRANSITIONS = {
  :up => :right,
  :right => :down,
  :down => :left,
  :left => :up
}

def count_loops map, element, dir, seen, recurse
  loops = 0
  loop do
    next_element = element.adjacent_element_in_direction(dir)
    next_pos = next_element&.position
    case map[next_pos]
    when true
      if recurse
        map[next_pos] = false
        loops += 1 if seen.none? { |_pos, _| _pos == next_pos } &&
                      count_loops(map, element, dir, seen.clone, false)
        map[next_pos] = true
      end
      element = next_element
      return true unless seen.add? [element.position, dir]
    when false
      dir = DIRECTIONS_TRANSITIONS[dir]
    when nil
      return recurse && loops
    end
  end
end

input = ARGF.readlines.map {|line| line.strip.split('') }
grid = BidimensionalArray.new(input)

map = {}
start_element = nil

grid.each do |line|
  line.each do |element|
    map[element.position] = element.value != '#'
    start_element = element if element.value == '^'
  end
end

puts count_loops(map, start_element, :up, Set.new([[start_element.position, 0]]), true)
