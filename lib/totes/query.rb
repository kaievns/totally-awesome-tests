#
# Represents the subject query (the left side of the assertions)
#
module Totes
  class Query
    def initialize(subject)
      @subject = subject
    end

    def must(*args)
      if matcher = args[0]
        try { matcher.test(@subject, fail_on: false) }
      else
        OperationsWrapper.new(self, :must)
      end
    end

    def wont(*args)
      if matcher = args[0]
        try { matcher.test(@subject, fail_on: true) }
      else
        OperationsWrapper.new(self, :wont)
      end
    end

    def method_missing(*args, &block)
      Totes::Query.new(@subject.__send__ *args, &block)
    end

    # passing core methods (like :to_s and so on onto the subject as well)
    (Class.new.instance_methods - [:__send__, :__id__, :object_id, :is_a?, :==]).each do |core_method|
      define_method core_method do |*args, &block|
        method_missing core_method, *args, &block
      end
    end

  private

    def try(&block)
      yield

      Totes::Reporter.inst.passed self
    rescue Totes::Error => e
      Totes::Backtrace.filter e
      Totes::Reporter.inst.failed e
    end

    # the naughty operations matchers wrapper
    class OperationsWrapper
      def initialize(query, method)
        @query  = query
        @method = method
      end

      [:==, :"!=", :=~, :<=, :>=, :<, :>].each do |operation|
        define_method operation do |*args, &block|
          @query.__send__ @method, Totes::Matcher.build(operation, *args, &block)
        end
      end
    end
  end
end
