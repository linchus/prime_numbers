matrix_size = ARGV.first.to_i
abort('Matrix size should be greater then 0') unless matrix_size > 0

require_relative 'lib/my_prime'
require 'terminal-table'

numbers = MyPrime.new.take(matrix_size)
data = [[''] + numbers]
numbers.each do |prime|
  data << numbers.map { |element| element * prime }.unshift(prime)
end

puts Terminal::Table.new rows: data


