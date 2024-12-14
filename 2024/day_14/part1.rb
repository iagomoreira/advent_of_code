WIDTH = 101
HEIGHT = 103

# WIDTH = 11
# HEIGHT = 7
QUADRANTS = [
  [(0...WIDTH/2), (0...HEIGHT/2)],
  [(WIDTH/2...WIDTH), (0...HEIGHT/2)],
  [(0...WIDTH/2), (HEIGHT/2...HEIGHT)],
  [(WIDTH/2...WIDTH), (HEIGHT/2...HEIGHT)]
]

PATTERN = /p=(-*\d+,-*\d+) v=(-*\d+,-*\d+)/
input = ARGF.readlines(chomp: true).map do |line|
  position, velocity = line.match(PATTERN).captures

  {pos: position.split(',').map(&:to_i), vel: velocity.split(',').map(&:to_i)}
end

def quadrant(position)
  QUADRANTS.each_with_index do |quadrant, i|
    return i.to_s if quadrant[0].include?(position[0]) && quadrant[1].include?(position[1])
  end
end

def new_position(robot, seconds)
  x, y = robot[:pos]
  vx, vy = robot[:vel]

  new_x = (x + vx * seconds) % WIDTH
  new_y = (y + vy * seconds) % HEIGHT

  return nil if new_x == WIDTH/2 || new_y == HEIGHT/2

  quadrant =
  [new_x, new_y, quadrant([new_x, new_y])]
end

new_positions = input.map{|robot| new_position(robot, 100) }.compact

puts new_positions.group_by(&:last).transform_values(&:size).values.reduce(:*)
