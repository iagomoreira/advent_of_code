require "active_support/core_ext/array/grouping"
require_relative "elf"

food_by_elves = File.readlines(ARGV[0]).map(&:chomp).split("")
elves = food_by_elves.map {|food_items| Elf.new(food_items) }
max_total_calories = elves.max

p max_total_calories.total_calories
