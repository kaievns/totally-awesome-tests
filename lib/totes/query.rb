#
# Represents the subject query (the left side of the assertions)
#
module Totes
  class Query < Noop
    def initialize(subject)
      @subject = Totes::Subject.new(subject)
    end

    def must(*args, &block)
      if matcher = args[0]
        __try__ { matcher.test(@subject, fail_on: false) }
      else
        OperationsWrapper.new(self, :must)
      end
    end

    def wont(*args, &block)
      if matcher = args[0]
        __try__ { matcher.test(@subject, fail_on: true) }
      else
        OperationsWrapper.new(self, :wont)
      end
    end

    def method_missing(name, *args, &block)
      Totes::Query.new(@subject.__send__ name, *args, &block)
    end

  private

    def __try__(&block)
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
