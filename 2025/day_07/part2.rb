require_relative '../../utils/bidimensional_array'

MATRIX = BidimensionalArray.new(ARGF.readlines(chomp: true).map(&:chars))
starting_index = MATRIX.first.size/2
VISITED = {}
def move_downward(element)
  VISITED[element.position] ||= begin
    new_element = element.adjacent_element_in_direction(:down)

    if new_element.nil?
      return 1
    elsif new_element.value == '^'
      left_element = new_element.adjacent_element_in_direction(:left)
      right_element = new_element.adjacent_element_in_direction(:right)

      move_downward(left_element) + move_downward(right_element)
    else
      move_downward(new_element)
    end
  end
end

element = MATRIX[0][starting_index]

puts move_downward(element)
