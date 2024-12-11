input = ARGF.readline(chomp: true).split(' ')

result = input.dup

def halves(str)
  first_half = str[0...str.size/2].to_i.to_s
  second_half = str[str.size/2...str.size].to_i.to_s

  [first_half, second_half]
end

def blink(n, input)
  result = input.dup
  n.times do
    new_result = []
    result.each do |n|
      if n == '0'
        new_result << '1'
      elsif n.size.even?
        new_result += halves(n)
      else
        new_result << (n.to_i * 2024).to_s
      end
    end
    result = new_result
  end
  result
end

start_time = Time.now
part_1 = blink(25, input)
end_time = Time.now
puts "Result = #{part_1.size} ran in #{end_time - start_time} seconds"

start_time = Time.now
part_2 = blink(50, part_1)
end_time = Time.now
puts "Result = #{part_2.size} ran in #{end_time - start_time} seconds"
