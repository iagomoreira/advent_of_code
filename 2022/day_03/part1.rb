require_relative "rucksack"

rucksacks = File.readlines(ARGV[0]).map(&:chomp).map {|rucksack| Rucksack.new(rucksack) }
puts rucksacks.map(&:repeated_item_values).sum


