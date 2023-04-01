require_relative './bubble_sort'
require_relative './helper_spec'

RSpec.describe 'Bubble Sort' do
  begin
    $stdout << "Choose sorting order:\n1. asc \n2. desc\n"
    while (input = $stdin.gets.chomp)
      case input
      when 'asc', '1', 'exit', 'EXIT', ''
        input = 'asc'
        break
      when 'desc', '2'
        input = 'desc'
        break
      end
    end

    puts "sorting in #{input == 'asc' ? 'ascending' : 'descending'} order"
    let!(:sorting_order) { input }
  end

  context 'sort array of numbers' do
    it 'successfully' do
      array = [9, 8, 7, 6, 5, 4, 3, 2, 1]
      bubble_sorted_array = bubble_sort(array, sorting_order: sorting_order)

      expect(sorted_array?(bubble_sorted_array, sorting_order: sorting_order)).to eq(true)
    end
  end

  context 'sort array based on any numerical criteria' do
    it 'successfully' do
      array_of_words = ['hello', 'world', 'a', 'Ruby on Rails']
      bubble_sorted_array = bubble_sort(array_of_words, sorting_order: sorting_order, &:length)
      
      expect(sorted_array?(bubble_sorted_array, sorting_order: sorting_order, &:length)).to eq(true)
    end
  end
end
