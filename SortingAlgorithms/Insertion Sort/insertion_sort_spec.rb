require 'rspec'
require_relative './insertion_sort'
require_relative './../helper_spec'

RSpec.describe 'Insertion Sort' do
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
      array = [1, 9, 3, 6, 5, 2, 4, 7, 8]
      insertion_sorted_array = insertion_sort(array, sorting_order: sorting_order)

      expect(sorted_array?(insertion_sorted_array, sorting_order: sorting_order)).to eq(true)
    end
  end

  context 'sort array based on any numerical criteria' do
    it 'successfully' do
      array_of_words = ['hello', 'world', 'a', 'Ruby on Rails']
      insertion_sorted_array = insertion_sort(array_of_words, sorting_order: sorting_order, &:length)

      expect(sorted_array?(insertion_sorted_array, sorting_order: sorting_order, &:length)).to eq(true)
    end
  end
end
