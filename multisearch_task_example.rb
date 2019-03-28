require './app'

require 'benchmark'
# example how to run multisearch task

search_term = 'Ruby Meetup'

sequential_search = Tasks::MultisearchTask.new(search_term, parallel: false)
parallel_search = Tasks::MultisearchTask.new(search_term)

#p "Sequential search:", sequential_search.call
#p "Parallel search", parallel_search.call

puts "Sequential search:", Benchmark.measure { sequential_search.call }
puts "Parallel search: ", Benchmark.measure { parallel_search.call }
