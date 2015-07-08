#
# Represents the subject query (the left side of the assertions)
#
module Totes
  class Query
    def initialize(subject)
      @subject = subject
    end

    def must(matcher)
      matcher.test(@subject, fail_on: false)
    end

    def wont(matcher)
      matcher.test(@subject, fail_on: true)
    end
  end
end
