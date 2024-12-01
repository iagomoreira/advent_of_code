first_list, second_list = File.readlines(ARGV[0]).map do |line|
  line.split.map(&:to_i)
end.transpose

similarity_score = 0

first_list.each do |location_id|
  similarity_score += location_id * second_list.count(location_id)
end

puts similarity_score
