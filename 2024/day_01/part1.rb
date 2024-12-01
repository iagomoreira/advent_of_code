first_list, second_list = File.readlines(ARGV[0]).map do |line|
  line.split.map(&:to_i)
end.transpose

first_list = first_list.sort
second_list = second_list.sort

distance = 0

first_list.each_with_index do |n, i|
  distance += (n - second_list[i]).abs
end

puts distance
