INPUT = File.readlines(ARGF.filename).map {|line| line.chomp.split('') }
NEXT_POSSIBLE_CHAR = {
  'X' => 'M',
  'M' => 'A',
  'A' => 'S'
}

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

def has_xmas_in_direction(current_position, direction)
  i, j = current_position
  current_char = INPUT[i][j]
  next_char, next_position = fetch_next_character_and_position(current_position, direction)
  wanted_char = NEXT_POSSIBLE_CHAR[current_char]

  if next_char && next_char == wanted_char
    if next_char == 'S'
      return true
    end

    has_xmas_in_direction(next_position, direction)
  else
    false
  end
end

words_found = 0

INPUT.each_with_index do |line, i|
  line.each_with_index do |char, j|
    if char == 'X'
      words_found += 1 if has_xmas_in_direction([i,j], :up)
      words_found += 1 if has_xmas_in_direction([i,j], :down)
      words_found += 1 if has_xmas_in_direction([i,j], :left)
      words_found += 1 if has_xmas_in_direction([i,j], :right)
      words_found += 1 if has_xmas_in_direction([i,j], :up_left)
      words_found += 1 if has_xmas_in_direction([i,j], :up_right)
      words_found += 1 if has_xmas_in_direction([i,j], :down_left)
      words_found += 1 if has_xmas_in_direction([i,j], :down_right)
    end
  end
end


puts words_found
