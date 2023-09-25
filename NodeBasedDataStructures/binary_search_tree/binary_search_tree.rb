require 'byebug'

# 1. create a BST from a randomly ordered
ARRAY = [50, 25, 10, 33, 4, 11, 75, 56, 89, 52, 61, 82, 95, 12]

class IllegalDataStructure < StandardError
end

class Node
  attr_accessor :data, :left_child, :right_child

  def initialize(data: nil, left_child: nil, right_child: nil)
    @data = data
    @left_child = left_child
    @right_child = right_child
  end
end

class Tree
  attr_accessor :root_node

  def initialize(container:)
    @container = container

    case container.class.to_s
    when Array.to_s
      construct_tree(container: container)
    else
      raise IllegalDataStructure
    end
  end

  def traverse(node:)
    return if node.nil?

    traverse(node: node.left_child)
    puts node.data
    traverse(node: node.right_child)
  end

  def search(data:, node:)
    return node if node.nil? || node.data == data

    if data < node.data
      search(data: data, node: node.left_child)
    else
      search(data: data, node: node.right_child)
    end
  end

  def insert(data:, node:)
    return if node.nil?

    new_node = Node.new(data: data)
    container << data unless container.include?(data)

    if data < node.data
      node.left_child =
        if node.left_child.nil?
          new_node
        else
          insert(data: data, node: node.left_child)
        end
    elsif data > node.data
      node.right_child =
        if node.right_child.nil?
          new_node
        else
          insert(data: data, node: node.right_child)
        end
    end

    node
  end

  def delete(data:, node:)
    return node if node.nil?

    if data < node.data
      node.left_child = delete(data: data, node: node.left_child)
      node
    elsif data > node.data
      node.right_child = delete(data: data, node: node.right_child)
      node
    elsif data == node.data
      if node.left_child.nil?
        node.right_child
      elsif node.right_child.nil?
        node.left_child
      else
        node.right_child = find_successor_node(target_node: node, node: node.right_child)
        node
      end
    end

    nodes.delete(data)
  end

  def find_successor_node(target_node:, node:)
    if node.left_child
      node.left_child = find_successor_node(target_node: target_node, node: node.left_child)
      node
    else
      target_node.data = node.data
      node.right_child
    end
  end

  def nodes
    container
  end

  private

  attr_accessor :container

  def construct_tree(container:)
    container_clone = container.clone
    self.root_node = Node.new(data: container_clone[0])

    current_node = root_node

    container_clone[1, container_clone.length - 1].each do |ele|
      insert(data: ele, node: current_node)
    end
  end
end

def tree
  Tree.new(container: ARRAY)
end
