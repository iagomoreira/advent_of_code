require "active_support/core_ext/array/grouping"
require_relative "rucksack"
require_relative "elf_group"


rucksacks = File.readlines(ARGV[0]).map(&:chomp).map {|rucksack| Rucksack.new(rucksack) }

elf_groups = rucksacks.in_groups_of(3).map {|elf_group| ElfGroup.new(elf_group) }

p elf_groups.map(&:badge_value).sum
