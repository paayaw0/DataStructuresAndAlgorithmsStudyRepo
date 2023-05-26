class NegativeIndexError < StandardError
end

class NoMethodOfInsertion < StandardError
end

class NoMethodOfDeletion < StandardError
end

class Node 
    attr_accessor :data, :previous_node, :next_node

    def initialize(data)
        @data = data
    end
end

class DoublyLinkedList
    attr_accessor :first_node, :last_node 

    def initialize(first_node: nil, last_node: nil)
        @first_node = first_node
        @last_node = last_node
    end

    def read_value_from(index:)
        begin 
            Integer(index)
        rescue 
            raise "index is not an Integer"
        end

        raise NegativeIndexError if index.negative?

        current_node = first_node 
        current_index = 0

        while current_index < index 
            current_node = current_node.next_node
            current_index += 1

            return nil unless current_node
        end
        current_node.data
    end

    def search_value(value:)
        puts "search for #{value}:"

        current_node = first_node
        current_index = 0

        while current_node 
            if value == current_node.data 
                return current_index
            end

            current_node = current_node.next_node
            current_index += 1 

            return nil unless current_node
        end

        current_index
    end
    
    require 'byebug'

    def insert_at(index:, value:, method:)
        raise NoMethodOfInsertion if index.nil? && method.nil? 

        begin 
            Integer(index)
        rescue TypeError
            puts "Allow nil value since method is present"
        rescue 
            raise "index is not an Integer"
        end

        raise NegativeIndexError if index&.negative?

        node = Node.new(value)

        case {method: method, index: index}
        in {method: :beginning, index: nil} | {method: nil, index: 0}
            node.previous_node = nil
            node.next_node = first_node.next_node
            self.first_node = node
        in method: :end
            node.previous_node = last_node 
            node.next_node = nil
            self.last_node = node
        in method: nil, index: Integer
           current_node = first_node
           current_index = 0
           
           while current_index < (index - 1)
               current_node = current_node.next_node
               current_index += 1

               return nil unless current_node
           end

           node.next_node = current_node.next_node
           node.previous_node = current_node
        end
    end

    def delete_at(index:, method:)
        raise NoMethodOfDeletion if index.nil? && method.nil? 

        begin 
            Integer(index)
        rescue TypeError
            puts "Allow nil value since method is present"
        rescue 
            raise "index is not an Integer"
        end

        raise NegativeIndexError if index&.negative?

        case {index: index, method: method}
        in {index: 0, method: nil} | {index: nil, method: :beginning}
            self.first_node = first_node.next_node
            first_node.previous_node = nil
            first_node
        in method: :end 
            self.last_node = last_node.previous_node 
            last_node.next_node = nil
            last_node
        in {index: Integer, method: nil}
            current_node = first_node 
            current_index = 0 

            while current_index < (index - 1)
                current_node = current_node.next_node
                current_index += 1 

                return nil unless current_node
            end

            node_after_deleted_node = current_node.next_node.next_node
            node_after_deleted_node.previous_node = current_node
            current_node.next_node = node_after_deleted_node
        end
    end
end

node1 = Node.new('first node')
node2 = Node.new('second node')
node3 = Node.new('third node')
node4 = Node.new('fourth node')

node1.previous_node = nil 
node1.next_node = node2 
node2.previous_node = node1 
node2.next_node = node3
node3.previous_node = node2 
node3.next_node = node4 
node4.previous_node = node3 
node4.next_node = nil



dl = DoublyLinkedList.new(first_node: node1, last_node: node4)
# p dl.read_value_from(index: 3)
# p dl.search_value(value: 'first node')

# p dl.insert_at(index: nil, value: 'new node', method: :beginning)
# p dl.insert_at(index: nil, value: "new node", method: :end)
# p dl.insert_at(index: 0, value: 'new node', method: nil)
# p dl.insert_at(index: 2, value: 'new node', method: nil)
# p dl.delete_at(index: 0, method: nil)
# p dl.delete_at(index: nil, method: :end)
p dl.delete_at(index: 3, method: nil)
