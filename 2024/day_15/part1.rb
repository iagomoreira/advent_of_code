require 'matrix'
WALL = '#'
EMPTY_SPACE = '.'
BOX = 'O'

def get_direction(instruction)
  case instruction
  when 'v'
    Vector[1,0]
  when '^'
    Vector[-1,0]
  when '>'
    Vector[0,1]
  when '<'
    Vector[0,-1]
  end
end

def move(position, instruction, map)
  current = map[position]

  direction = get_direction(instruction)
  new_position = position + direction
  return if map[new_position] == WALL || map[new_position].nil?

  if map[new_position] == BOX
    move(new_position, instruction, map)
  end

  if map[new_position] == EMPTY_SPACE
    map[new_position] = map[position]
    map[position] = EMPTY_SPACE
    return current == '@' ? new_position : nil
  end
end

grid, instructions = ARGF.read.split("\n\n")
start_position = nil
map = {}

grid.split("\n").each_with_index do |line, i|
  line.chars.each_with_index do |char, j|
    start_position = Vector[i,j] if char == '@'
    map[Vector[i,j]] = char
  end
end

instructions = instructions.gsub!("\n", "").chars

current_position = start_position
instructions.each do |instruction|
  new_position = move(current_position, instruction, map)
  current_position = new_position unless new_position.nil?
end

result = map.find_all {|k,v| v == BOX }.sum do |(position, _)|
  x, y = position.to_a
  100 * x + y
end

puts result
