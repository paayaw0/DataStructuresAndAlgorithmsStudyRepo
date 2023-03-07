require 'byebug'
# abstract data type based on the array but with a defined rule of allowing only unique elements
class DuplicateValueError < StandardError; end

class ArrayBasedSet
  attr_accessor :array

  def initialize
    @array = []
  end

  def read(index)
    array[index]
  end

  def search(value)
    last_index = array.length - 1 
    index = 0

    loop do
      break if index > last_index

      return index if array[index] == value

      index += 1
    end
  end

  def insert(index, value)
    raise DuplicateValueError if value_already_exists?(value)

    (array[index] = value) && (return true) if index.zero? && array.empty?
    (array << value) && (return true) if index == array.length || array.length == 1

    return unless array.length > 1

    no_of_shifts = array.length - index
    pointer_index = array.length - 1

    while no_of_shifts > 0
      array[pointer_index + 1], array[pointer_index] = array[pointer_index], nil
      no_of_shifts -= 1
      pointer_index -= 1
      p array
    end
    array[index] = value if array[index].nil?
  end

  def delete; end


  private 

  def value_already_exists?(value)
    index = 0

   loop do
     break if index > array.length - 1
     return true if array[index] == value

     index += 1
   end

    false
  end
end

abs = ArrayBasedSet.new

abs.insert(0, 44)
abs.insert(1, 'hi')
abs.insert(2, :u)
abs.insert(3, 9)

p abs.array
abs.insert(1, :insert)
p abs.array
p abs.search('hai')
abs.insert(0, 9)
