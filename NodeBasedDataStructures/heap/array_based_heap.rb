require 'byebug'

class Node
end

class NodeBasedHeap; end

class ArrayBasedHeap
  attr_accessor :array
  attr_reader :height_of_heap, :current_level

  def initialize(array = [])
    @array = array
    @height_of_heap = calculate_height_of_heap
    @current_level = 0
  end

  def root_node
    array[0]
  end

  def last_node
    array[array.length - 1]
  end

  def construct_heap; end

  def level_of_insertion
    height_of_heap - current_level
  end

  def insert(value)
    array << value

    node_index = array.length - 1

    while array[node_index] > array[parent_node_index(node_index)]
      array[node_index], array[parent_node_index(node_index)] = array[parent_node_index(node_index)], array[node_index]
      node_index = parent_node_index(node_index)
      @current_level += 1

      break if parent_node_index(node_index) < 0
    end
  end

  def delete
    # delete root node
    array[0] = array.pop

    node_index = 0

    # check with child nodes and pick greater child node and swap with it
    while (left_child_index(node_index) > 0 && (array[left_child_index(node_index)] && array[left_child_index(node_index)] > array[node_index])) || (right_child_index(node_index) > 0 && (array[right_child_index(node_index)] && array[right_child_index(node_index)] > array[node_index]))
      if array[left_child_index(node_index)] > node_index
        array[left_child_index(node_index)], array[node_index] = array[node_index], array[left_child_index(node_index)]
        node_index = left_child_index(node_index)
      elsif array[right_child_index(node_index)] > node_index
        array[right_child_index(node_index)], array[node_index] = array[node_index],
array[right_child_index(node_index)]
        node_index = right_child_index(node_index)
      end
    end
  end

  def size
    array.length
  end

  private

  def left_child_index(index)
    (index * 2) + 1
  end

  def right_child_index(index)
    (index * 2) + 2
  end

  def parent_node_index(index)
    (index - 1) / 2
  end

  def calculate_height_of_heap
    Math.log(size, 2).floor
  end
end

array = [100, 88, 25, 87, 16, 8, 12, 86, 50, 2, 15, 3]

heap =  ArrayBasedHeap.new(array)
# heap.delete
heap.insert(102)
p heap.array
