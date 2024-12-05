require_relative '../../utils/bidimensional_array'

words_file = File.readlines(ARGF.filename).map {|line| line.chomp.split('') }
VALID_DIAGONAL_COMBINATIONS = [
  ['M', 'S'],
  ['S', 'M']
]

def has_cross_mas_in_both_diagonals(current_char)
  diagonal_up_left = current_char.adjacent_element_in_direction(:up_left)
  diagonal_down_right = current_char.adjacent_element_in_direction(:down_right)

  diagonal_up_right = current_char.adjacent_element_in_direction(:up_right)
  diagonal_down_left = current_char.adjacent_element_in_direction(:down_left)

  VALID_DIAGONAL_COMBINATIONS.include?([diagonal_up_left, diagonal_down_right]) && VALID_DIAGONAL_COMBINATIONS.include?([diagonal_up_right, diagonal_down_left])
end

words_found = 0

input = BidimensionalArray.new(words_file)

input.each do |line|
  line.each do |char|
    if char == 'A'
      words_found += 1 if has_cross_mas_in_both_diagonals(char)
    end
  end
end


puts words_found
