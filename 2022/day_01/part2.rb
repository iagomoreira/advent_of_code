require "active_support/core_ext/array/grouping"
require_relative "elf"

food_by_elves = File.readlines(ARGV[0]).map(&:chomp).split("")
elves = food_by_elves.map {|food_items| Elf.new(food_items) }
sorted_elves = elves.sort

p sorted_elves.last(3).sum {|elf| elf.total_calories }
