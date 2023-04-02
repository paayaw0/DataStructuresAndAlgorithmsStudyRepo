def insertion_sort(array, sorting_order:)
  if sorting_order == 'asc'
    index = 1
    last_index = array.length - 1

    loop do
      break if index > last_index

      temp_value = array[index]
      lvi = index - 1 # lvi=left_value_index

      while lvi >= 0
        no_need_to_shift =
          if block_given?
            yield(array[lvi]) < yield(temp_value)
          else
            array[lvi] < temp_value
          end

        break if no_need_to_shift

        array[lvi + 1] = array[lvi]
        lvi -= 1
      end

      array[lvi + 1] = temp_value

      index += 1
    end
  else
    index = -2
    last_index = - array.length

    loop do
      break if index < last_index

      temp_value = array[index]
      rvi = index + 1 # rvi= right_value_index

      while rvi <= -1
        no_need_to_shift =
          if block_given?
            yield(array[rvi]) < yield(temp_value)
          else
            array[rvi] < temp_value
          end

        break if no_need_to_shift

        array[rvi - 1] = array[rvi]
        rvi += 1
      end

      array[rvi - 1] = temp_value

      index -= 1
    end
  end

  array
end
