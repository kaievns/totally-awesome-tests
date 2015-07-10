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

  private

    def try(&block)
      yield

      Totes::Reporter.inst.passed self
    rescue Totes::Error => e
      Totes::Reporter.inst.failed e
    end
  end
end
