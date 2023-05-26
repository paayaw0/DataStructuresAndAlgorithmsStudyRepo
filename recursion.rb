@number_of_recursive_calls = 0
array = [1, 2, 3, 4, 5]

def array_sum(array)
  return 0 if array.empty?

  array[0] + array_sum(array[1..array.length])
end

# p array_sum(array)

string = 'abcde'

def reverse_string(string)
  return '' if string.empty?

  reverse_string(string[1, string.length - 1]) + string[0]
end

# p reverse_string(string)

string = 'axbxcxdxx'

def count_x(string)
  return 0 if string.empty?

  count_x(string[1, string.length - 1]) + (string[0] == 'x' ? 1 : 0)
end

# p count_x(string)

string = 'abcd'

def anagram_of(string)
  #   @number_of_recursive_calls += 1
  return [string[0]] if string.length == 1

  collection = []

  list_of_anagrams = anagram_of(string[1, string.length - 1])
  list_of_anagrams.each do |anagram|
    0.upto(anagram.length).each do |index|
      copy = String.new(anagram)
      collection << copy.insert(index, string[0])
    end
  end

  collection
end

# p anagram_of(string)
# 1.  Use recursion to write a function that accepts an array of strings and
# returns the total number of characters across all the strings. For example,
# if the input array is ["ab", "c", "def", "ghij"], the output should be 10 since there
# are 10 characters in total.

array = %w[ab c def ghij]

def xter_total(array)
  return 0 if array.empty?

  array[0].size + xter_total(array[1, array.length - 1])
end

# p xter_total(array)

# 2. Use recursion to write a function that accepts an array of numbers and
# returns a new array containing just the even numbers.

numbers = [1, 2, 3, 4, 8, 100, 202]

def even_numbers(numbers)
  @number_of_recursive_calls += 1
  
  return [] if numbers.empty?

  e_numbers = even_numbers(numbers[1, numbers.length - 1])
  if numbers[0].even?
    [numbers[0], *e_numbers]
  else
    e_numbers
  end
end

p even_numbers(numbers)

# 3. There is a numerical sequence known as “Triangular Numbers.” The
# pattern begins as 1, 3, 6, 10, 15, 21, and continues onward with the Nth
# number in the pattern, which is N plus the previous number. For example,
# the 7th number in the sequence is 28, since it’s 7 (which is N) plus 21
# (the previous number in the sequence). Write a function that accepts a
# number for N and returns the correct number from the series. That is, if
# the function was passed the number 7, the function would return 28.

n = 7

def traingle_numbers(n)
  @number_of_recursive_calls += 1
  return 1 if n <= 1

  n + traingle_numbers(n - 1)
end

# p traingle_numbers(n)

# 4.Use recursion to write a function that accepts a string and returns the
# first index that contains the character “x.” For example, the string,
# "abcdefghijklmnopqrstuvwxyz" has an “x” at index 23. To keep things simple,
# assume the string definitely has at least one “x.”

string = 'abcdefghijklmnopqrstuvwxyz'

def find_index_of_x(string)
  # @number_of_recursive_calls += 1
  return 0 if string[0] == 'x'

  find_index_of_x(string[1, string.length - 1]) + 1
end

# p find_index_of_x(string)

p @number_of_recursive_calls
