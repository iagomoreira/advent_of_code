cards = File.readlines(ARGV[0]).map(&:strip)

pattern = /Card\s+\d+:\s+(\d+(?:\s+\d+)*)\s+\|\s+(\d+(?:\s+\d+)*)/

points = cards.map do |card|
  winning_numbers, own_numbers = card.match(pattern).captures.map {|numbers| numbers.split.map(&:to_i) }
  matching_numbers = winning_numbers & own_numbers

  (2 ** (matching_numbers.size - 1)).floor
end.sum

puts points
