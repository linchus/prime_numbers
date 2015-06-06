describe MyPrime do
  let(:generator) { described_class.new }
  let(:first_100_primes) { [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101] }
  let(:second_100_primes) { [103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199] }

  describe '.take' do
    subject { generator.take(numbers_count) }
    context 'with numbers_count less than predefined nums' do
      let(:numbers_count) { 3 }
      it 'return cached values' do
        expect(generator).not_to receive(:get_next_chunk)
        expect(subject).to eq [2, 3, 5]
      end
    end

    context 'with numbers_count greater than predefined nums' do
      let(:numbers_count) { 30 }
      it 'calculate more numbers' do
        expect(generator).to receive(:get_next_chunk).and_call_original
        subject
      end
    end

    context 'with several chunks' do
      let(:numbers_count) { first_100_primes.size + second_100_primes.size }
      before do
        stub_const('MyPrime::MAX_CHUNK_SIZE', 6)
      end

      it 'generate numbers until enough' do
        expect(subject).to eq first_100_primes + second_100_primes
      end
    end
  end

  describe '.get_next_chunk' do
    subject { generator.get_next_chunk }
    it 'generate next chunk of primes' do
      expect{ subject }.to change{ generator.primes }.from(first_100_primes).to(first_100_primes + second_100_primes)
    end
  end
end
