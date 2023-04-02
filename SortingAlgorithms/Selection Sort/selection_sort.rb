def selection_sort(array, sorting_order:)
  op = sorting_order == 'asc' ? :< : :>

  outer_index = 0
  last_index = array.length - 1 # we don't need to sort the last index so we can stop at the index before
  lowest_value_index = outer_index # assume that the first index is our lowest

  while outer_index < last_index
    inner_index = outer_index + 1
    lowest_value_index = outer_index

    while inner_index < array.length
      lowest_value_found =
        if block_given?
          yield(array[inner_index]).send(op, yield(array[lowest_value_index]))
        else
          array[inner_index].send(op, array[lowest_value_index])
        end

      lowest_value_index = inner_index if lowest_value_found

      inner_index += 1
    end

    array[outer_index], array[lowest_value_index] = array[lowest_value_index], array[outer_index]
    outer_index += 1
  end

  puts "unsorted: #{unsorted_array}"
  puts "sorted: #{array}"
  puts ""

  array
end
