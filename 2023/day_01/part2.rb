calibration_lines = File.readlines(ARGV[0]).map(&:chomp)

number_words = %w(one two three four five six seven eight nine)

calibration_values = []

calibration_lines.each do |cal_line|
  digits = []
  cal_line.chars.each_with_index do |c, i|
    digits << c if c =~ /\d/
    number_words.each.with_index(1) {|word,index| digits << index if cal_line[i..-1].start_with?(word) }
  end
  calibration_values << digits.join[0] + digits.join[-1]
end

puts calibration_values.sum {|v| v.to_i }
