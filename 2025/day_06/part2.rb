input = ARGF.readlines.map {|line| line.chomp.chars }.transpose

results = 0

ops = []
stack = []

def solve_operations(stack, ops)
  op = ops.join
  values = stack.reject {|v| v == 0}

  eval(values.join(op))
end

input.each do |*values, op|
  if values.all? {|v| v == ' '}
    results += solve_operations(stack, ops)
    ops = []
    stack = []
  end
  ops << op.strip
  stack <<  values.join.to_i
end

results += solve_operations(stack, ops)

puts results
