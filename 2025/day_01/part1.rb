INITIAL_POSITION = 50
current_position = INITIAL_POSITION
zero_counter = 0

def direction_factor(direction)
  {'L' => -1, 'R' => 1}.fetch(direction)
end

File.readlines(ARGF.filename).each do |line|
  direction, *steps = line.chomp.chars
  steps = steps.join.to_i * direction_factor(direction)
  new_position = (current_position + steps) % 100
  # puts "Direction: #{direction}, Steps: #{steps}, Current Position Before Move: #{current_position}, New Position: #{new_position}"
  current_position = new_position
  zero_counter += 1 if current_position.zero?
end

puts "Zero Counter: #{zero_counter}"
