cards = File.readlines(ARGV[0]).map(&:strip)

pattern = /Card\s+(\d+):\s+(\d+(?:\s+\d+)*)\s+\|\s+(\d+(?:\s+\d+)*)/

scores = {}

cards.each do |card|
  card_id, winning_numbers, own_numbers = card.match(pattern).captures.map {|numbers| numbers.split.map(&:to_i) }
  card_id = card_id.first
  scores[card_id] = { score: 0, count: 1 }
  matching_numbers = winning_numbers & own_numbers

  scores[card_id][:score] = matching_numbers.count
end

scores.each do |key, value|
  ((key + 1)..key + value[:score]).each do |idx|
    scores[idx][:count] = scores[idx][:count] + value[:count]
  end
end

puts scores.values.map { |x| x[:count] }.sum
