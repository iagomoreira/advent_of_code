directory_sizes = Hash.new(0)

File.readlines(ARGV[0], chomp: true).map(&:split).each_with_object([]) do |line, stack|
  case line
  in ['$', 'cd', '..']
    stack.pop
  in ['$', 'cd', directory]
    stack.push [stack.last, directory].compact.join(' ')
  in [size, file] if size.match?(/^\d+$/)
    stack.each { |i| directory_sizes[i] += size.to_i }
  else
  end
  p stack
end
p directory_sizes
puts directory_sizes.values.reject { |i| i > 100_000 }.sum
puts directory_sizes.values.reject { |i| i < directory_sizes['/'] - 40_000_000 }.min
