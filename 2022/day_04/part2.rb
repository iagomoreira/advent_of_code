pairs = File.readlines(ARGV[0]).map {|line| line.chomp.split(',') }
overlaping_assignments = 0

pairs.each do |pair|
  assignment_1_range = pair[0].split("-").map(&:to_i)
  assignment_2_range = pair[1].split("-").map(&:to_i)

  if ((assignment_1_range[0].between?(*assignment_2_range) || assignment_1_range[1].between?(*assignment_2_range)) || (assignment_2_range[0].between?(*assignment_1_range) || assignment_2_range[1].between?(*assignment_1_range)))
    overlaping_assignments += 1
  end
end

p overlaping_assignments
