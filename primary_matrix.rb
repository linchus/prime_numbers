matrix_size = ARGV.first.to_i
abort('Matrix size should be greater then 0') unless matrix_size > 0

require_relative 'lib/my_prime'

numbers = MyPrime.new.take(matrix_size)
cell_size = (numbers.last ** 2).to_s.length
row_mask = " %#{cell_size}s |" * (matrix_size + 1)
puts format(row_mask, '', *numbers)
numbers.each do |prime|
  puts format(row_mask, prime, *numbers.map { |element| element * prime })
end


