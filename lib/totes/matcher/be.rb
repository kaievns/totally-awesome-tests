module Totes
  class Matcher::Be < Totes::Matcher
    def likes(subject)
      @subject = subject
      @value === @subject
    end

    def failure(positive=true)
      if positive
        "expected #{@subject} to be #{@value}, but it ain't"
      else
        "expected #{@subject} ain't be #{@value}, but was"
      end
    end
  end
end
