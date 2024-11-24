# classic linked list

require 'byebug'

class Node
    attr_accessor :data, :next_node

    def initialize(data, next_node=nil)
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

        while current_index < index
            current_index += 1
            current_node = current_node.next_node
        end

        return current_node&.data 
    end

    def search(value)
        current_index = 0
        current_node = first_node

        while current_node
            if current_node.data == value
                return current_index
            else
                current_index += 1
                current_node = current_node.next_node
            end
        end

        return nil
    end

    def insert(value, target_index)
        node = Node.new(value)
        current_index = 0
        current_node = first_node

        if target_index == 0
            node.next_node = first_node
            first_node = node
            
            return node
        end

        while current_node
            if current_index < (target_index - 1)
                if current_node.next_node.nil?
                    current_node.next_node = node

                    return node
                end

                current_node = current_node.next_node
                current_index += 1
            else
                node.next_node = current_node.next_node
                current_node.next_node = node
                
                return node
            end
        end

        first_node = node
    end

    # a -> b -> c -> d
    def delete(value)
        current_index = 0
        current_node = first_node
        

        while current_node
            previous_node = current_node

            if previous_node.data == value && current_index == 0
                self.first_node = previous_node.next_node
                return self
            end

            current_node = current_node.next_node
            current_index += 1

            if current_node&.data == value
                previous_node.next_node = current_node.next_node

                return self
            end
        end
    end
end


node1 = Node.new(
    'a',
    Node.new(
        'b',
        Node.new(
            'c',
            Node.new(
                'd'
            )
        )
    )
)
# byebug

linked_list = LinkedList.new(node1)

puts 'reading...'
p linked_list.read(4)

puts ''

puts 'searching...'
p linked_list.search('c')

puts ''

puts 'inserting...'
linked_list.insert(0, 2)
p linked_list

puts '' 

puts 'deleting...'
linked_list.delete('b')
p linked_list
