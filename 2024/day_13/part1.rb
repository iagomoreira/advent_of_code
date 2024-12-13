require 'z3'

BUTTON_PATTERN = /Button (A|B): X\+(\d+), Y\+(\d+)/
PRIZE_PATTERN = /Prize: X=(?<x_prize>\d+), Y=(?<y_prize>\d+)/
def parse_button(button)
  key, x, y = button.match(BUTTON_PATTERN).captures

  [key.to_sym, [x.to_i, y.to_i]]
end

def parse_prize(prize)
  x_prize, y_prize = prize.match(PRIZE_PATTERN).captures

  [:prize, [x_prize.to_i, y_prize.to_i]]
end

def parse_input(input)
  input.chomp.split("\n\n").map do |machine_group|
    button_a, button_b, prize = machine_group.split("\n")

    [parse_button(button_a), parse_button(button_b), parse_prize(prize)].to_h
  end
end

def run_machine(machine)
  solver = Z3::Solver.new

  a =  Z3.Int('a')
  b =  Z3.Int('b')

  solver.assert(a > 0)
  solver.assert(b > 0)
  solver.assert(machine[:A][0] * a + machine[:B][0] * b == machine[:prize][0])
  solver.assert(machine[:A][1] * a + machine[:B][1] * b == machine[:prize][1])

  return nil if solver.unsatisfiable?

  [solver.model[a].to_i, solver.model[b].to_i]
end

machines_result = parse_input(ARGF.read).map do |machine|
  calc_result = run_machine(machine)
  next if calc_result.nil?
  a_press, b_press = calc_result
  (3 * a_press) + b_press
end

p machines_result.compact.sum
