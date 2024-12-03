MULTIPLIER_PATTERN = /mul\((\d+),(\d+)\)/
input = File.read(ARGV[0]).chomp

result =input.scan(MULTIPLIER_PATTERN).map do |m|
  m[0].to_i * m[1].to_i
end.sum

puts result
