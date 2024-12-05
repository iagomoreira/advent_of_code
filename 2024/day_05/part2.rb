rules, updates = File.read(ARGF.filename).split("\n\n").map {|line| line.split("\n") }

parsed_rules = {}

rules.each do |rule|
  k, v = rule.split('|').map(&:to_i)
  parsed_rules[k] ||= []
  parsed_rules[k] << v
end

updates.map! {|update| update.split(',').map(&:to_i) }
valid_updates = []
invalid_updates = []

updates.each do |update|
  update.each_with_index do |n, i|
    rule = parsed_rules[n]
    if rule&.any? {|r| update.index(r) && i > update.index(r) }
      invalid_updates << update
      break
    elsif i == update.size - 1
      valid_updates << update
    end
  end
end

result = invalid_updates.map do |update|
  update.sort do |a,b|
    if parsed_rules[a] && parsed_rules[a].include?(b)
      -1
    elsif parsed_rules[b] && parsed_rules[b].include?(a)
      1
    else
      0
    end
  end
end.sum {|update| update[update.size/2] }

puts result
