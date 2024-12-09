def position_valid?(position, x_size, y_size)
  x, y = position
  (0...x_size).include?(x) && (0...y_size).include?(y)
end

def get_antinodes(antenna_map, x_size, y_size)
  antinodes = Set.new

  antenna_map.each do |_, positions|
    positions.combination(2).each do |(x1, y1), (x2, y2)|
      antinode_1 = [x1 + (x1 - x2), y1 + (y1 - y2)]
      antinodes << antinode_1 if position_valid?(antinode_1, x_size, y_size)
      antinode_2 = [x2 + (x2 - x1), y2 + (y2 - y1)]
      antinodes << antinode_2 if position_valid?(antinode_2, x_size, y_size)
    end
  end

  antinodes
end

antenna_map = Hash.new {|h,k| h[k] = [] }

grid_lines = ARGF.readlines(chomp: true)
x_size = grid_lines.size
y_size = grid_lines.first.size

grid_lines.each_with_index do |line, i|
  line.chars.each_with_index do |char, j|
    if char != '.'
      antenna_map[char] << [i,j]
    end
  end
end

antinodes = get_antinodes(antenna_map, x_size, y_size)

puts antinodes.size
