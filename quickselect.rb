# Quickselect is a hybrid of quick sort and binary search. It uses partioning to
# determine pivot index and that is compared with the value to be searched to determine
# which side of the pivot index to recursively partition.

require_relative 'quicksort'

class Quicksort
  def select(nth_value, left_index, righ_index)
    # return pivot if array is empty or has just one element
    pivot_index = partition!(left_index, righ_index)

    return array[pivot_index] if righ_index - left_index <= 0

    if nth_value < pivot_index
      select(nth_value, left_index, pivot_index - 1)
    elsif nth_value > pivot_index
      select(nth_value, pivot_index + 1, righ_index)
    else
      array[pivot_index]
    end
  end
end

array = [100, 50, 20, 10, 60, 30]

quick_sort = Quicksort.new array
p quick_sort.array
p quick_sort.select(5, 0, array.length - 1)
