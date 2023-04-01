def bubble_sort(array)
  last_index = array.length - 1
  last_sorted_index = last_index
  unsorted = true

  while unsorted
    index = 0
    unsorted = false

    loop do
      break if index == last_sorted_index

      l_pointer = index
      r_pointer = index + 1

      need_to_swap =
        if block_given?
          yield(array[l_pointer]) > yield(array[r_pointer])
        else
          array[l_pointer] > array[r_pointer]
        end

      if need_to_swap
        array[l_pointer], array[r_pointer] = array[r_pointer], array[l_pointer]
        unsorted = true
      end

      index += 1
    end

    last_sorted_index -= 1
  end

  array
end
