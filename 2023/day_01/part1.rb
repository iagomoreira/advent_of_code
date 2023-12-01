calibration_lines = File.readlines(ARGV[0]).map(&:chomp)

calibration_values = calibration_lines.map do |cal_line|
  number_values = cal_line.gsub(/\D/, '').chars
  (number_values.first + number_values.last).to_i
end

puts calibration_values.sum
