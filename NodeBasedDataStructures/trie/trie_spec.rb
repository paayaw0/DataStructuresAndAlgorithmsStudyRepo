require 'rspec'
require 'byebug'
require_relative 'trie'

RSpec.describe Trie do
  let!(:node) { Node.new(children: {}) }
  let!(:trie) { described_class.new(root_node: node) }
  let!(:sample_words) { 
    [
      'concurrency',
      'go',
      'golang',
      'concurrent',
      'currency',
      'current',
      'cat',
      'catnip',
      'catnap'
    ]
  }

  before do
    sample_words.each do |word|       
      trie.insert(word: word)
    end
  end

  describe '#search' do
    it 'return node if word is found' do
      search_word = 'current'
      expect(trie.search(word: search_word)&.children).to_not eq(nil)
    end

    it 'return nil if word is not found' do
      search_word = 'ruby'
      expect(trie.search(word: search_word)&.children).to eq(nil)
    end
  end


  describe '#insert' do
    it 'should be able to search newly inserted word' do
      new_word = 'gophers'
      trie.insert(word: new_word)
      expect(trie.search(word: new_word)&.children).to_not eq(nil)
    end

    it 'search for new word should fail if not inserted' do
      new_word = 'currencies'
      expect(trie.search(word: new_word)&.children).to eq(nil)
    end
  end

  describe '#autocomplete' do
    it 'return array of suggested words' do
      expect(trie.autocomplete(word: 'go')).to eq(['go', 'golang'])
    end
  end

  describe '#autocorrect' do
    it 'suggest the most correct word for misspelled word' do
      misspelled_word = 'curent'
      expect(trie.autocorrect(word: misspelled_word)).to eq('current')
    end
  end
end