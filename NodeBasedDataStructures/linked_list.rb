# LinkedList implementation in Ruby
class NegativeIndexError < StandardError 
end

class Node 
    attr_accessor :data, :next_node 

    def initialize(data)
        @data = data 
        @next_node = nil
    end
end

class LinkedList 
    attr_accessor :first_node 

    def initialize(first_node)
        @first_node = first_node
    end

    def read_value_from(index)
        begin 
            Integer(index)
        rescue 
            raise "index is not an Integer"
        end

        raise NegativeIndexError if index.negative?
        
        puts "read value from index #{index}:"

        current_node = first_node 
        current_index = 0 

        while current_index < index 
            current_node = current_node.next_node
            current_index += 1

            return nil if current_node.nil?
        end
        
        current_node
    end

    def search_value(value)
        puts "lookup index of this value #{value}:"

        current_node = first_node 
        current_index = 0 

        while current_node
            if current_node.data == value 
                return current_index 
            end
            
            current_node = current_node.next_node
            current_index += 1
        end

        current_index unless current_node.nil?
    end

    def insert_at(index, value)
        begin 
            Integer(index)
        rescue 
            raise "index is not an Integer"
        end
        
        raise NegativeIndexError if index.negative?

        puts "insert #{value} at #{index}":

        node = Node.new(value)
        
        if index == 0 
            node.next_node = first_node 
            self.first_node = node 
        else
            current_node = first_node 
            current_index = 0 

            while current_index < (index - 1)
                current_node = current_node.next_node
                current_index += 1
            end

            node.next_node = current_node.next_node
            current_node.next_node = node 
        end
    end

    def delete_at(index)
        begin 
            Integer(index)
        rescue 
            raise "index is not an Integer"
        end

        raise NegativeIndexError if index.negative?

        puts "delete value at #{index}"

        current_node = first_node
        current_index = 0 

        if index == 0
            self.first_node = first_node.next_node
        else
            while current_index < (index - 1)
                current_node = current_node.next_node
                current_index += 1
            end

            current_node.next_node = current_node.next_node.next_node
        end
    end
end


node1 = Node.new('first node')
node2 = Node.new('second node')
node3 = Node.new('third node')
node4 = Node.new('fourth node')

node1.next_node = node2 
node2.next_node = node3 
node3.next_node = node4
node4.next_node = nil

# p node1

ll = LinkedList.new(node1)
# p ll.read_value_from(3)

# p ll.search_value('third node')

# p ll.insert_at(1, 'new node?')

# p ll.read_value_from(1)

p ll.delete_at(3)

# p ll.read_value_from(1)

# DoublyLinkedList implementation in Ruby
