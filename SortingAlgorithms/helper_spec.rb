require 'byebug'

def sorted_array?(array, sorting_order:)
  op =
    if sorting_order == 'asc'
      :>
    else
      :<
    end

  array.each_index do |index|
    break if array[index + 1].nil?

    unsorted =
      if block_given?
        yield(array[index]).send(op, yield(array[index + 1]))
      else
        array[index].send(op, array[index + 1])
      end

    return false if unsorted
  end

  true
end
