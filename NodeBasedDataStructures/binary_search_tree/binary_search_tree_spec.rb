require 'rspec'
require_relative 'binary_search_tree'

RSpec.describe 'Binary Search Tree' do
  let!(:container) { [50, 40, 52, 38, 41, 51, 54] }
  let!(:tree) { Tree.new(container: container) }
  let!(:root_node) { tree.root_node }

  it 'raise exception if illegal data structure is used' do
    expect { Tree.new(container: {}) }.to raise_error(IllegalDataStructure)
  end
  
  it 'return root node to equal first element in container' do
    expect(tree.root_node.data).to eq(container[0])
  end

  context 'search node in tree' do
    it 'return nil for non-existent node' do
      expect(tree.search(data: 49, node: root_node)).to eq(nil)
    end
  
    it 'returns node when it exists' do
      expect(tree.search(data: 38, node: root_node)).to be_a(Node)
    end
  end

  context 'insert node in tree' do
    it 'do not insert if node already exists' do
      expect { tree.insert(data: 41, node: root_node) }.to_not change(tree.nodes, :count)
    end

    it 'insert new node' do
      expect { tree.insert(data: 43, node: root_node) }.to change(tree.nodes, :count).by(1)
    end
  end

  context 'delete node from tree' do
    it 'do not delete if node is non-existent' do
      expect { tree.delete(data: 55, node: root_node) }.to_not change(tree.nodes, :count)
    end

    it 'deletes existent node' do
      expect { tree.delete(data: 38, node: root_node) }.to change(tree.nodes, :count).by(-1)
    end
  end
end
