require_relative '../../utils/bidimensional_array'

def search_trail(grid, position, visited_peaks)
  current_element = grid.dig(*position)

  if current_element == 9
    visited_peaks.add(position)
    return visited_peaks
  end

  [:up, :down, :left, :right].each do |direction|
    next_element = current_element.adjacent_element_in_direction(direction)

    search_trail(grid, next_element.position, visited_peaks) if next_element == current_element + 1
  end

  visited_peaks
end

input = []
trail_head_positions = []

ARGF.readlines(chomp:true).each_with_index do |line, i|
  line_arr = []
  line.chars.each_with_index do |c, j|
    trail_head_positions << [i, j] if c == '0'
    line_arr << c.to_i
  end
  input << line_arr
end
input = BidimensionalArray.new(input)
trail_head_score = 0
trail_head_positions.each do |position|
  visited_peaks = search_trail(input, position, Set.new([]))
  trail_head_score += visited_peaks.size
end

p trail_head_score
