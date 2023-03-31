def insertion_sort(array)
  index = 1
  last_index = array.length - 1

  loop do
    break if index > last_index

    temp_value = array[index]
    lvi = index - 1 # lvi=left_value_index

    while lvi >= 0
      break unless array[lvi] > temp_value

      break if block_given? && !(yield(array[lvi]) > yield(temp_value))

      array[lvi + 1] = array[lvi]
      lvi -= 1
    end

    array[lvi + 1] = temp_value

    index += 1
  end

  array
end
