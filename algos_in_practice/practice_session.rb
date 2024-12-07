require 'byebug'
class Node
  attr_accessor :data, :left_child, :right_child

  def initialize(data = nil, left_child = nil, right_child = nil)
    @data = data
    @left_child = left_child
    @right_child = right_child
  end

  def next_node=(node)
    if node.data < self.data
      if left_child.nil?
        self.left_child = node
      end
    else
      if right_child.nil?
        self.right_child = node
      end
    end
  end

  def to_s
    "Node -> data: #{self.data || 'none'}, left_child: #{self.left_child || 'none'}, right_child: #{self.right_child || 'none'}"
  end

  def display
    to_s
  end

  def inspect
    display
  end
end

class BinarySearchTree
  attr_accessor :root_node

  def initialize(root_node = nil)
    @root_node = root_node
  end

  def search_node(node_value, current_node = self.root_node)
    return current_node if (node_value == current_node&.data) || current_node.nil?

    if node_value < current_node.data
      search_node(node_value, current_node.left_child)
    else
      search_node(node_value, current_node.right_child)
    end
  end

  def construct_tree(array)
    tree = self
    index = 0
    pointer = 1    
    
    while (index + pointer) < array.length
      if index == 0
        tree.root_node = Node.new(array[index])
        current_node = tree.root_node
      end
    
      
      current_node.next_node = Node.new(array[index + pointer])
      current_node.next_node = Node.new(array[index + pointer+= 1])
      index += 1
      current_node = tree.search_node(array[index], tree.root_node)
    end
  end

  def insert_node(value, current_node = self.root_node)
    node = Node.new(value)

    if node.data < current_node.data
      if current_node.left_child.nil?
        current_node.left_child = node
      else
        insert_node(value, current_node.left_child)
      end
    else
      if current_node.right_child.nil?
        current_node.right_child = node
      else
        insert_node(value, current_node.right_child)
      end
    end
  end

  def find_successor_node(value, current_node)
    return if current_node.nil?

    if current_node.left_child
      current_node.left_child = find_successor_node(value, current_node.left_child)
      return current_node
    else
      node_to_delete = search_node(value, self.root_node)
      node_to_delete.data, current_node.data = current_node.data, node_to_delete.data
      return current_node.right_child
    end
  end

  def delete_node(value, current_node = self.root_node)
    return if current_node.nil?

    if value < current_node.data
      current_node.left_child = delete_node(value, current_node.left_child)
      return current_node
    elsif value > current_node.data
      current_node.right_child = delete_node(value, current_node.right_child)
      return current_node
    elsif value == current_node.data
      if current_node.left_child.nil?
        return current_node.right_child
      elsif current_node.right_child.nil?
        return current_node.left_child
      else
        current_node.right_child = find_successor_node(value, current_node.right_child)
        return current_node
      end
    end
  end
end

tree = BinarySearchTree.new

array = [50, 25, 75, 10, 33, 56, 89, 4, 11, 30, 40, 52, 61, 82, 95]

tree.construct_tree(array)

# tree.insert_node(88)
tree.delete_node(25)

p tree


