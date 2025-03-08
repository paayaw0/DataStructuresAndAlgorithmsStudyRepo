# Practice Session

# In Dijkstra’s Algorithm, on page 367, we saw how Dijkstra’s algorithm
# helped us find the shortest path within a weighted graph. However, the
# concept of a shortest path exists within an unweighted graph as well.
# How?
# The shortest path in a classic (unweighted) graph is the path that takes
# the fewest number of vertices to get from one vertex to another.
# This can be especially useful in social networking applications. Take the
# example network that follows:
# If we want to know how Idris is to connected Lina, we’d see that she’s
# connected to her from two different directions. That is, Idris is a second-
# degree connection to Lina through Kamil, but she is also a fifth-degree
# connection through Talia. Now, we’re probably interested in how closely
# Idris is connected to Lina, so the fact that she’s a fifth-degree connection
# is unimportant given that they’re also second-degree connections.
# Write a function that accepts two vertices from a graph and returns the
# shortest path between them. The function should return an array contain-
# ing the precise path, such as ["Idris", "Kamil", "Lina"].
# Hint: The algorithm may contain elements of both breadth-first search
# and Dijkstra’s algorithm.

# path = ['Idris', 'Kamil', 'Lina']
require 'byebug'
require 'rspec'

GRAPH = {
  'idris' => ['kamil', 'talia'],
  'talia' => ['idris', 'ken'],
  'ken' => ['talia', 'marco'],
  'marco' => ['ken', 'sasha'],
  'sasha' => ['marco', 'lina'],
  'lina' => ['sasha', 'kamil'],
  'kamil' => ['lina', 'idris']
}


def shortest_path(initial_vertex, final_vertex, ask_for_number_of_connections: false)
  path = []

  queue = Queue.new
  connections_from_starting_vertex = 0
  visited_vertex = {}
  number_of_connections_from_starting_vertex_to = {}
  immediate_stopover_vertex_from_starting_vertex_to = {}

  queue.enq initial_vertex

  while queue.size > 0
    current_vertex = queue.deq
    visited_vertex[current_vertex] = true

    if initial_vertex == current_vertex
      number_of_connections_from_starting_vertex_to[current_vertex] = 0
      immediate_stopover_vertex_from_starting_vertex_to[current_vertex] = initial_vertex
    end
    
    GRAPH[current_vertex].entries.each do |neighbor|
      unless visited_vertex[neighbor]
        visited_vertex[neighbor] = true

        queue.enq neighbor

        if number_of_connections_from_starting_vertex_to[neighbor].nil?
          number_of_connections_from_starting_vertex_to[neighbor] = 0
          number_of_connections_from_starting_vertex_to[neighbor] += number_of_connections_from_starting_vertex_to[current_vertex].to_i + 1
          immediate_stopover_vertex_from_starting_vertex_to[neighbor] = current_vertex
        end
      end
    end

  end
  
  path << final_vertex

  track = final_vertex
  
  while immediate_stopover_vertex_from_starting_vertex_to[track] != initial_vertex
    path << immediate_stopover_vertex_from_starting_vertex_to[track]
    track = immediate_stopover_vertex_from_starting_vertex_to[track]
  end

  path << initial_vertex
  path.reverse!

  if ask_for_number_of_connections
    return {
      path: path,
      number_of_connection: number_of_connections_from_starting_vertex_to[final_vertex] - number_of_connections_from_starting_vertex_to[initial_vertex]
    }
  end

  path
end



context 'shortest_path' do  
  it 'provide shortest path betwee any 2 given vertices' do
    expect(shortest_path('idris', 'lina')).to eq(['idris', 'kamil', 'lina'])
    expect(shortest_path('talia', 'marco')).to eq(['talia', 'ken', 'marco'])
  end

  it 'returns both path and number of connections' do
    expect(shortest_path('talia', 'marco', ask_for_number_of_connections: true)).to eq(
      
    { path: ['talia', 'ken', 'marco'], number_of_connection: 2})
  end
end




