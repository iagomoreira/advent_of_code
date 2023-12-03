require_relative 'game'

input_lines = File.readlines(ARGV[0]).map(&:chomp)

games = input_lines.map do |line|
  match_data = line.match(/Game (?<id>\d+): (?<sets>.*)/)
  Game.new(match_data[:id], match_data[:sets])
end

puts "Part 1: #{games.select(&:valid?).sum(&:id)}"
puts "Part 2: #{games.sum(&:cube_set_power)}"
