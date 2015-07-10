module Totes
  class Spec
    attr_reader :subject

    StartOver = Class.new(StandardError)

    def initialize(*args, &block)
      @subject = __get_subject__(*args)
      @__block = block
      @__specs = [] # inner specs list
      @__count = {
        queries: 0, # global queries counter
        current: 0  # the current query marker
      }
    end

    def describe(*args, &block)
      @__specs << self.class.new(*args, &block).tap do |spec|
        spec.instance_variable_set("@__count", @__count)
      end
    end

    # returns the _subject_ query object
    def it
      if @__count[:current] == @__count[:queries]
        @__count[:queries] += 1
        Totes::Query.new(@subject) # going in for real
      elsif @__count[:current] > @__count[:queries]
        @__count[:queries] += 1
        SkipQuery.new # rerunning through a previous query, skipping
      else
        @__count[:current] += 1 # switching to the next query
        raise StartOver
      end
    end

    alias :its :it # more readable on subqueries

    # builds the matchers
    def method_missing(*args, &block)
      Totes::Matcher.build(*args, &block) || super(*args, &block)
    end

  private

    def __get_subject__(*args)
      return args[0] # TODO make it smarter
    end

    class SkipQuery
      def must(*args); end # don't trigger the matchers
      def wont(*args); end # don't trigger the matchers

      def method_missing(*args, &block)
        self # endlessly return self
      end

      # passing core methods (like :to_s and so on onto the subject as well)
      (Class.new.instance_methods - [:__send__, :__id__, :object_id]).each do |core_method|
        define_method core_method do |*args, &block|
          method_missing core_method, *args, &block
        end
      end
    end
  end
end
