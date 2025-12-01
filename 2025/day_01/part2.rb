INITIAL_POSITION = 50
current_position = INITIAL_POSITION
zero_counter = 0

def direction_factor(direction)
  {'L' => -1, 'R' => 1}.fetch(direction)
end

puts "The dial starts at position #{INITIAL_POSITION}."
File.readlines(ARGF.filename).each do |line|
  direction, *steps = line.chomp.chars
  steps = steps.join.to_i * direction_factor(direction)
  new_position = (current_position + steps)
  passing_zero_counter, new_adjusted_position  = new_position.divmod(100)
  zero_counter += passing_zero_counter.abs
  puts "The dial is rotated #{line.chomp} to point at #{new_adjusted_position}, it points at zero #{passing_zero_counter.abs} times."
  current_position = new_adjusted_position
end

puts "Zero Counter: #{zero_counter}"
