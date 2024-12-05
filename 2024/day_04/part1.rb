require_relative '../../utils/bidimensional_array'
words_file = File.readlines(ARGF.filename).map {|line| line.chomp.split('') }
NEXT_POSSIBLE_CHAR = {
  'X' => 'M',
  'M' => 'A',
  'A' => 'S'
}

def has_xmas_in_direction(element, direction)
  next_char = element.adjacent_element_in_direction(direction)
  wanted_char = NEXT_POSSIBLE_CHAR[element]

  if next_char && next_char == wanted_char
    if next_char == 'S'
      return true
    end

    has_xmas_in_direction(next_char, direction)
  else
    false
  end
end

words_found = 0

input = BidimensionalArray.new(words_file)
input.each do |line|
  line.each do |char|
    if char == 'X'
      words_found += 1 if has_xmas_in_direction(char, :up)
      words_found += 1 if has_xmas_in_direction(char, :down)
      words_found += 1 if has_xmas_in_direction(char, :left)
      words_found += 1 if has_xmas_in_direction(char, :right)
      words_found += 1 if has_xmas_in_direction(char, :up_left)
      words_found += 1 if has_xmas_in_direction(char, :up_right)
      words_found += 1 if has_xmas_in_direction(char, :down_left)
      words_found += 1 if has_xmas_in_direction(char, :down_right)
    end
  end
end

puts words_found
