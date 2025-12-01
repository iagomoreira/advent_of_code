require 'matrix'
WALL = '#'
START = 'S'
FINISH_LINE = 'E'
EMPTY_SPACE = '.'

DIRECTIONS = {
  up: Vector[-1,0],
  down: Vector[1,0],
  left: Vector[0,-1],
  right: Vector[0,1],
}

AVAILABLE_TURNS = {
  up: %i(left right),
  down: %i(left right),
  left: %i(up down),
  right: %i(up down)
}
def find_path(start_position, map, direction, path_scores, score = 0)
  direction_vector = DIRECTIONS[direction]
  forward_position = start_position + direction_vector

  # CHECK IF END POSITION
  if map[start_position] == FINISH_LINE
    path_scores << score
    return
  end

  # MOVE FORWARD IF POSSIBLE
  if map[forward_position] == EMPTY_SPACE || map[forward_position] == FINISH_LINE
    find_path(forward_position, map, direction, path_scores, score + 1)
  end

  # CHECK TURNS
  turn_a, turn_b = AVAILABLE_TURNS[direction]

  turn_a_position = start_position + DIRECTIONS[turn_a]
  if map[turn_a_position] == EMPTY_SPACE || map[turn_a_position] == FINISH_LINE
    find_path(turn_a_position, map, turn_a, path_scores, score + 1000)
  end

  turn_b_position = start_position + DIRECTIONS[turn_b]
  if map[turn_b_position] == EMPTY_SPACE || map[turn_b_position] == FINISH_LINE
    find_path(turn_b_position, map, turn_b, path_scores, score + 1000)
  end
end
map = {}
start_position = nil
end_position = nil
initial_direction = :right
path_scores = []

ARGF.readlines(chomp: true).each_with_index.map do |line, i|
  line.chars.each_with_index.map do |char, j|
    map[Vector[i,j]] = char
    start_position = Vector[i,j] if char == START
    end_position = Vector[i,j] if char == FINISH_LINE
  end
end

find_path(start_position, map, initial_direction, path_scores)


p path_scores
puts path_scores.min
