def bubble_sort(array, sorting_order:)
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

      op = sorting_order == 'asc' ? :> : :<

      need_to_swap =
        if block_given?
          yield(array[l_pointer]).send(op, yield(array[r_pointer]))
        else
          array[l_pointer].send(op, (array[r_pointer]))
        end

      if need_to_swap
        array[l_pointer], array[r_pointer] = array[r_pointer], array[l_pointer]
        unsorted = true
      end

      index += 1
    end

    last_sorted_index -= 1
  end

  puts "unsorted: #{unsorted_array}"
  puts "sorted: #{array}"
  puts ""

  array
end
