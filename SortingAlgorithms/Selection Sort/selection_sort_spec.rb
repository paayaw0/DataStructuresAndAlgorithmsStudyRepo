require 'rspec'
require_relative './selection_sort'
require_relative './../helper_spec'

RSpec.describe 'Selection Sort' do
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
  end

  puts "sorting in #{input == 'asc' ? 'ascending' : 'descending'} order"
  let!(:sorting_order) { input }

  context 'sort array of numbers' do
    it 'successfully' do
      array = [1, 9, 3, 6, 5, 2, 4, 7, 8].shuffle
      selection_sorted_array = selection_sort(array, sorting_order: sorting_order)

      expect(sorted_array?(selection_sorted_array, sorting_order: sorting_order)).to eq(true)
    end
  end

  context 'sort array based on any numerical criteria' do
    it 'successfully' do
      array_of_words = ['hello', 'world', 'a', 'Ruby on Rails'].shuffle
      selection_sorted_array = selection_sort(array_of_words, sorting_order: sorting_order, &:length)

      expect(sorted_array?(selection_sorted_array, sorting_order: sorting_order, &:length)).to eq(true)
    end
  end
end
