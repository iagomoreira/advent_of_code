def position_valid?(position, x_size, y_size)
  x, y = position
  (0...x_size).include?(x) && (0...y_size).include?(y)
end

def get_antinodes(antenna_map, x_size, y_size, multiplier = 0)
  antinodes = Set.new

  antenna_map.each do |_, positions|
    positions.combination(2).each do |(x1, y1), (x2, y2)|
      multiplier.step do |m|
        antinode_1 = [x1 + m * (x1 - x2), y1 + m * (y1 - y2)]
        break unless position_valid?(antinode_1, x_size, y_size)
        antinodes << antinode_1
      end

      multiplier.step do |m|
        antinode_2 = [x2 + m * (x2 - x1), y2 + m * (y2 - y1)]
        break unless position_valid?(antinode_2, x_size, y_size)
        antinodes << antinode_2
      end
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
