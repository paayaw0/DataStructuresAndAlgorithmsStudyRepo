require 'byebug'

# Graphs
# Dijkstra's Algorithm

# find the cheapest flight path

class Queue
    attr_accessor :queue

    def initialize
        @queue = []
    end

    def enqueue(obj)
        @queue << obj
    end

    def dequeue
        @queue.shift
    end

    def read
        @queue[0]
    end
end

graph_of_city_flight_paths = {
    'atlanta' => {'boston' => 100,  'denver' => 160},
    'boston' => {'denver' => 180, 'chicago' => 120},
    'chicago' => {'el paso' => 80},
    'denver' => {'chicago' => 40, 'el paso' => 140},
    'el paso' => {'boston' => 100}
}

def dijkstra_cheapest_flight_path_algorithm(graph, initial_city)
    visited_cities = {}
    unvisited_cities = []

    cheapest_path_from_initial_city = {}
    recent_stopover_city_from_initial_city = {}

    queue = Queue.new
    queue.enqueue(initial_city)

    while queue.read
        current_city = queue.dequeue

        visited_cities[current_city] = true
        unvisited_cities.delete(current_city)

        graph[current_city].each_pair do |neighboring_city, value|
            unvisited_cities << neighboring_city unless visited_cities[neighboring_city]
            
            path_from_initial_city_to_neighboring_city = value + (cheapest_path_from_initial_city[current_city] || 0)

            if path_from_initial_city_to_neighboring_city < (cheapest_path_from_initial_city[neighboring_city] || 0) || cheapest_path_from_initial_city[neighboring_city].nil?
                cheapest_path_from_initial_city[neighboring_city] = path_from_initial_city_to_neighboring_city
                recent_stopover_city_from_initial_city[neighboring_city] = current_city
                queue.enqueue(neighboring_city)
            end
        end
        current_city = unvisited_cities.min do |city|
            cheapest_path_from_initial_city[city]
        end
    end

    puts 'cheapest/cheapest path from initial city/atlanta'
    p cheapest_path_from_initial_city

    puts 'recent stop overs from initial city/atlanta'
    p recent_stopover_city_from_initial_city
end


dijkstra_cheapest_flight_path_algorithm(graph_of_city_flight_paths, 'atlanta')
