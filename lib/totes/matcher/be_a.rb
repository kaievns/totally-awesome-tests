module Totes
  class Matcher::BeA < Totes::Matcher
    def likes(subject)
      @subject = subject
      @subject.is_a?(@value)
    end

    def failure(positive=true)
      "blah!"
    end
  end
end
