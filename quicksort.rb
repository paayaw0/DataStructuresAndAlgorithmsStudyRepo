# Quicksort is a sorting algorithm that involves partitioning and recursively partitioning as method to sorting elements of a dataset.
# It has the efficiency of O(n log n) for best and average cases. For worst scenarios, it has a time complexity of O(n2)
# below is an implementation of quick sort.

class Quicksort
  attr_reader :array

  def initialize(array)
    @array = array
  end

  def sort!(left_index, right_index)
    # do nothing if array/sub array has 0 or 1 element in it.
    return if right_index - left_index <= 0

    # find pivot index
    pivot_index = partition!(left_index, right_index)

    # recursivley partition the left sub array of pivot index
    sort!(left_index, pivot_index - 1)

    # recursively partition the right sub array of pivot index
    sort!(pivot_index + 1, right_index)
  end

  private

  def partition!(left_pointer, right_pointer)
    # establish left and right pointers
    # set pivot index and pivot(NOTE: pivot index can be selected a different way.
    # I chose to select the rightmost index of the given array)

    pivot_index = right_pointer
    pivot = array[pivot_index]

    right_pointer -= 1

    while true
      # move left pointer to the right until it is greater than pivot
      left_pointer += 1 while array[left_pointer] < pivot

      # move right pointer to the left until it is less than pivot
      right_pointer -= 1 while array[right_pointer] > pivot

      break if left_pointer >= right_pointer # break if left pointer reaches or goes beyond right pointer.

      # swap left pointer with right pointer, move left pointer by one and continue the loop
      array[left_pointer], array[right_pointer] = array[right_pointer], array[left_pointer]
      left_pointer += 1
    end

    array[left_pointer], array[pivot_index] = array[pivot_index], array[left_pointer]
    left_pointer
  end
end

array = [0, 5, 1, 2, 6, 3, 4, -11, -0.9]
quick_sort = Quicksort.new array
quick_sort.sort! 0, array.length - 1

p quick_sort.array
