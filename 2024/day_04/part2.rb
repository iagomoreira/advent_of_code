INPUT = File.readlines(ARGF.filename).map {|line| line.chomp.split('') }
VALID_DIAGONAL_COMBINATIONS = [
  ['M', 'S'],
  ['S', 'M']
]

def fetch_next_character_and_position(current_position, direction)
  i, j = current_position

  next_position = case direction
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
  next_char = if next_position.any?(&:negative?)
    nil
  else
    INPUT.dig(*next_position)
  end

  [next_char, next_position]
end

def has_cross_mas_in_both_diagonals(current_position)
  diagonal_up_left, _ = fetch_next_character_and_position(current_position, :up_left)
  diagonal_down_right, _ = fetch_next_character_and_position(current_position, :down_right)

  diagonal_up_right, _ = fetch_next_character_and_position(current_position, :up_right)
  diagonal_down_left, _ = fetch_next_character_and_position(current_position, :down_left)

  VALID_DIAGONAL_COMBINATIONS.include?([diagonal_up_left, diagonal_down_right]) && VALID_DIAGONAL_COMBINATIONS.include?([diagonal_up_right, diagonal_down_left])
end

words_found = 0

INPUT.each_with_index do |line, i|
  line.each_with_index do |char, j|
    if char == 'A'
      words_found += 1 if has_cross_mas_in_both_diagonals([i,j])
    end
  end
end


puts words_found
