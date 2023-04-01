require_relative './bubble_sort'

RSpec.describe 'Bubble Sort' do
  context 'sort array of numbers' do
    it 'successfully' do
      array = [9, 8, 7, 6, 5, 4, 3, 2, 1]
      sorted_array = array.sort

      expect(bubble_sort(array)).to eq(sorted_array)
    end
  end

  context 'sort array based on any numerical criteria' do
    it 'successfully' do
      array_of_words = ['hello', 'world', 'a', 'Ruby on Rails']
      sorted_array = array_of_words.sort_by(&:length)

      expect(bubble_sort(array_of_words, &:length)).to eq(sorted_array)
    end
  end
end
