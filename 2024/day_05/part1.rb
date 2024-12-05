rules, updates = File.read(ARGF.filename).split("\n\n").map {|line| line.split("\n") }

parsed_rules = {}

rules.each do |rule|
  k, v = rule.split('|')
  parsed_rules[k] ||= []
  parsed_rules[k] << v
end

updates.map! {|update| update.split(',') }
valid_updates = []
invalid_updates = []
result = 0

updates.each do |update|
  update.each_with_index do |n, i|
    rule = parsed_rules[n]
    if rule&.any? {|r| update.index(r) && i > update.index(r) }
      invalid_updates << update
      break
    elsif i == update.size - 1
      valid_updates << update
      result += update[update.size/2].to_i
    end
  end
end

puts result
