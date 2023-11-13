require 'rspec'
require_relative 'array_based_heap'

RSpec.describe ArrayBasedHeap do
  let!(:test_array) { [100, 88, 25, 87, 16, 8, 12, 86, 50, 2, 15, 3] }
  let!(:heap) { described_class.new(test_array) }

  describe '#delete' do
    it 'removes root_node' do
      root_node = heap.root_node

      expect(heap.root_node).to eq(root_node)

      heap.delete

      expect(heap.root_node).to_not eq(root_node)
    end

    it 'new root node should be next highest value' do
      next_highest_value = test_array.sort.reverse[1]

      heap.delete

      expect(heap.root_node).to eq(next_highest_value)
    end
  end

  describe '#insert' do
    it 'new root node if value inserted is greater than root node' do
      new_value = 102
      root_node = heap.root_node

      heap.insert(new_value)

      expect(heap.root_node).to eq(new_value)
    end

    it 'level of insertion should be 1 for the given inserted value' do
      new_value = 28
      heap.insert(new_value)

      expect(heap.level_of_insertion).to eq(1)
    end
  end

  describe 'height of heap should be' do
    it 'equals to 3 for the given test array' do
      expect(heap.height_of_heap).to eq(3)
    end
  end
end
