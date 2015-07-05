#
# Represents the subject query (the left side of the assertions)
#
module Totes
  class Query
    Error = Class.new(StandardError)

    def initialize(subject)
      @subject = subject
    end

    def must(matcher)
      if !matcher.likes(@subject)
        fail Error, matcher.failure
      end
    end

    def wont(matcher)
      if matcher.likes(@subject)
        fail Error, matcher.failure(false)
      end
    end
  end
end
