INSTRUCTION_PATTERN = /mul\(\d+,\d+\)|do(?:n't)?\(\)/
MULTIPLIER_PATTERN = /mul\((\d+),(\d+)\)/
should_ignore = false

scan = File.read(ARGV[0]).chomp.scan(INSTRUCTION_PATTERN)

result = scan.reduce(0) do |acc, instruction|
  case instruction
  when "don't()"
    should_ignore = true
    acc
  when "do()"
    should_ignore = false
    acc
  when MULTIPLIER_PATTERN
    if should_ignore
      acc
    else
      value = instruction.match(MULTIPLIER_PATTERN).captures.map(&:to_i).inject(:*)
      acc + value
    end
  end
end

puts result
