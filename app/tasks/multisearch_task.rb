require 'dry/monads/list'
require 'dry/monads/task'

module Tasks
=begin
Basic example how to run IO-bound tasks concurrently.

source:
https://blog.drewolson.org/concurrent-ruby-with-tasks
=end

  class MultisearchTask
    include Dry::Monads::List::Mixin
    include Dry::Monads::Task::Mixin

    attr_reader :parallel, :search_term

    def initialize(search_term, parallel: true)
      @search_term = search_term.to_s
      @parallel = parallel
    end

    # alias to run but gives some goodies like Proc
    def call
      results = parallel ? concurrent_search : sequential_search

      results.flatten.sort_by {|res| -res[:score]}
    end

    def sequential_search
      [database_lookup.value!, cache_lookup.value!, es_lookup.value!]
    end

    def concurrent_search
      List::Task[database_lookup, cache_lookup, es_lookup]
        .traverse
        .value! # executes list of tasks
        .value # fetches values from List monad
    end

    def concurrent2_search
      [database_lookup, cache_lookup, es_lookup].map(&:value!)
    end

    def cache_lookup
      res = [
        {score: 0.8, text: "kind of #{search_term[0..5]}", service: 'cache'}
      ]

      Task[:io] do
        sleep 1
        res
      end
    end

    def es_lookup
      res = [
        {score: 0.9, text: "almost #{search_term}", service: 'elasticsearch'}
      ]

      Task[:io] do
        sleep 2

        res
      end
    end

    def database_lookup
      res = [
        {score: 1.0, text: search_term.to_s, service: 'mysql'}
      ]

      Task[:io] do
        sleep 3

        res
      end
    end
  end
end

