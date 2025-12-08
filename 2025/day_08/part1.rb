require_relative 'junction_box'
require_relative 'junction_network'

junction_boxes = File.readlines(ARGV[0]).map {|line| JunctionBox.new(line.split(',').map(&:to_i)) }

network = JunktionNetwork.new(junction_boxes)

puts network.largest_circuits_value(ARGV[1].to_i, 3)
