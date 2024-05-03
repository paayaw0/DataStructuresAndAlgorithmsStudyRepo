class Node
  attr_accessor :children

  def initialize(children: {})
    @children = children  
  end
end

class Trie
  attr_accessor :root_node

  def initialize(root_node: nil)
    @root_node = root_node
  end

  def search(word:)
    current_node = root_node

    word.each_char do |char|
      if current_node.children[char]
        current_node = current_node.children[char]
        next
      else
        return nil
      end
    end

    return current_node
  end

  def insert(word:)
    current_node = root_node

    word.each_char do |char|
      if current_node.children[char]
        current_node = current_node.children[char]
        next
      else
        new_node = Node.new
        current_node.children[char] = new_node
        current_node = current_node.children[char]
      end
    end

    current_node.children['*'] = nil
  end

  def autocomplete(word:)
    node = self.search(word: word)
    
    return if node.nil?

    traverse_nodes(node: node, input: word)
  end

  def autocorrect(word:)
    current_node = root_node
    char_stream = ''

    word.each_char do |char|
      if current_node.children[char]
        current_node = current_node.children[char]
        char_stream << char
        next
      else
        break
      end
    end
    
    suggested_words = traverse_nodes(node: current_node, input: char_stream)
    
    suggested_words.sort! do |a, b|
      if a.length > word.length
        max_a, min_a = a, word
      else
        max_a, min_a = word, a
      end

      if b.length > word.length
        max_b, min_b = b, word
      else
        max_b, min_b = word, b
      end

      (max_a.split('').difference(min_a.split('')).length).abs <=> (max_b.split('').difference(min_b.split('')).length).abs
    end
    
    suggested_words
  end

  private

  def traverse_nodes(node:, word: '', suggested_words: [], input:)
    node ||= root_node

    node.children.each_pair do |key, child_node|
      if key == '*'
        suggested_words << input + word
      else
        traverse_nodes(node: child_node, word: word + key, suggested_words: suggested_words, input: input)
      end
    end

    suggested_words
  end
end