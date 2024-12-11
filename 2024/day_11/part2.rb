input = ARGF.readline(chomp: true).split(' ')

result = input.dup

def halves(str)
  first_half = str[0...str.size/2].to_i.to_s
  second_half = str[str.size/2...str.size].to_i.to_s

  [first_half, second_half]
end

def blink(n, input)
  result = input.tally

  n.times do |i|
    new_result = Hash.new { 0 }
    result.each do |n, count|
      if n == '0'
        new_result['1'] += count
        next
      elsif n.size.even?
        first_half, second_half = halves(n)
        new_result[first_half] += count
        new_result[second_half] += count
        next
      else
        new_value = (n.to_i * 2024).to_s
        new_result[new_value] += count
      end
    end
    result = new_result
  end
  result.values.sum
end

start_time = Time.now
part_2 = blink(75, input)
end_time = Time.now
puts "Result = #{part_2} ran in #{end_time - start_time} seconds"
