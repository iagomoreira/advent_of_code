require "active_support/core_ext/array/grouping"

def find_crater(id)
  if id == 1
    1
  else
    4 + find_crater(id-1)
  end
end

def populate_stacks(lines, stack_ids)
  stack_ids.map do |id|
    stack = []
    lines.reverse_each do |line|
      crater = line[find_crater(id)]
      stack.push crater if crater != ' '
    end
    [id.to_s, stack]
  end.to_h
end

def move_craters(stacks, instructions)
  instructions.each do |instruction|
    matches = instruction.match(/move (?<quantity>\d*) from (?<from>\d*) to (?<to>\d*)/)
    matches[:quantity].to_i.times do
      crater = stacks[matches[:from]].pop
      stacks[matches[:to]].push(crater)
    end
  end
end

lines, instructions = File.readlines(ARGV[0]).map(&:chomp).split("")
stack_ids = lines.pop.split.map(&:to_i)
populated_stacks = populate_stacks(lines, stack_ids)
move_craters(populated_stacks, instructions)
p populated_stacks.values.map {|stack| stack.last }.join
