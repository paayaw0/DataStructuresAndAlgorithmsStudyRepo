class Node
  attr_accessor :data, :next_node

  def initialize(data, next_node = nil)
    @data = data
    @next_node = next_node
  end
end

class LinkedList
  attr_accessor :first_node

  def initialize(first_node)
    @first_node = first_node
  end

  def read(index)
    current_node = first_node
    current_index = 0

    while current_node && current_index < index
      current_index += 1
      current_node = current_node.next_node

      puts "current_index #{current_index}, current_node #{current_node&.data}"
    end

    return current_node&.data
  end

  def index_of(value)
    current_index = 0
    current_node = first_node

    while current_node && current_node.data != value
      current_index += 1
      current_node = current_node.next_node
    end

    return current_node&.data
  end

  def insert_at_index(index, value)
    new_node = Node.new(value)
    
    if index == 0
      new_node.next_node = first_node
      self.first_node = new_node
      
      return
    end

    current_index = 0
    current_node = first_node

    while current_node && (current_index < (index - 1))
      current_index += 1
      current_node = current_node.next_node
    end

    new_node.next_node = current_node.next_node
    current_node.next_node = new_node
  end

  def delete_at_index(index)
    if index == 0
      self.first_node = first_node.next_node
      return
    end

    current_index = 0
    current_node = first_node

    while current_node && current_index < (index - 1)
      current_index += 1
      current_node = current_node.next_node    
    end

    node_after_deleted_node = current_node.next_node.next_node
    current_node.next_node = node_after_deleted_node
  end

  def print_nodes
    current_node = first_node

    while current_node
      puts current_node.data
      current_node = current_node.next_node
    end
  end
  
  def last_node
    current_node = first_node

    loop do
      break if current_node.next_node.nil?

      current_node = current_node.next_node
    end

    current_node&.data
  end


  def reverse_linked_list
    current_node = first_node
    previous_node = nil

    while current_node
      temp_node = current_node
      current_node = current_node.next_node

      temp_node.next_node = previous_node
      previous_node = temp_node
    end

    self.first_node = previous_node
  end
end

node1 = Node.new('one')
node2 = Node.new('two')
node3 = Node.new('three')
node4 = Node.new('four')

node1.next_node = node2
node2.next_node = node3
node3.next_node = node4

linked_list = LinkedList.new(node1)

puts linked_list.first_node

puts 'read'
puts linked_list.read(2)
puts ''
puts linked_list.read(9)
puts ''
puts 'search'
puts linked_list.index_of('three')
puts ''
puts linked_list.index_of('four')
puts linked_list.index_of('five')
puts ''
puts 'insert'
puts linked_list.read(1)
linked_list.insert_at_index(1, '1.5')
puts linked_list.read(1)
puts '-----'
puts linked_list.read(4)
linked_list.insert_at_index(4, 'five')
puts linked_list.read(4)
puts ''
puts 'delete'
puts linked_list.read(1)
linked_list.delete_at_index(1)
puts linked_list.read(1)
puts ''
puts 'print nodes'
linked_list.print_nodes
puts ''
puts 'print last nod'
puts linked_list.last_node
puts ''
puts 'reverse linked list'
puts linked_list.reverse_linked_list
linked_list.print_nodes

puts node3.data
puts ''

next_node = node3.next_node
node3.data =  next_node.data
node3.next_node = next_node.next_node

puts linked_list.print_nodes
array = ['one', 'two', 'three', 'four']

