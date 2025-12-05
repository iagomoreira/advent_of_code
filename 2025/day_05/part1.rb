ranges = []
fresh_ingredients = []

ARGF.readlines.each do |line|
  line = line.chomp
  next if line.empty?

  match_data = line.match(/(\d+)-(\d+)/)
  if match_data
    ranges << (match_data[1].to_i..match_data[2].to_i)
  else
    id = line.to_i
    fresh_ingredients << id if ranges.any? { |range| range.include?(id) }
  end
end

puts fresh_ingredients.size
