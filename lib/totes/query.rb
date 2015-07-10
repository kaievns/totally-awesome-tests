#
# Represents the subject query (the left side of the assertions)
#
module Totes
  class Query
    def initialize(subject)
      @subject = subject
    end

    def must(matcher)
      try { matcher.test(@subject, fail_on: false) }
    end

    def wont(matcher)
      try { matcher.test(@subject, fail_on: true) }
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
  end
end
