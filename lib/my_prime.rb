class MyPrime
  attr_reader :primes
  MAX_CHUNK_SIZE = 1_000_000

  def initialize
    @primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101]
    @last_checked = @primes.last + 1
  end

  def take(count)
    while @primes.size < count do
      get_next_chunk
    end
    @primes.take(count)
  end

  def get_next_chunk
    max_element = [@last_checked * 2, @last_checked + MAX_CHUNK_SIZE].min
    set = (@last_checked + 1 .. max_element).step(2).to_a
    offsets = @primes[1..-1].map { |p| (-(set.first + p) / 2) % p }
    @primes[1..-1].each_with_index do |prime, index|
      (offsets[index] .. set.size).step(prime).each do |sieve_index|
        set[sieve_index] = nil
      end
    end
    @primes += set.compact
    @last_checked = max_element
  end
end
