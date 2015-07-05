module Totes
  class Totes::Matcher::RespondTo < Totes::Matcher
    def likes(subject)
      @subject = subject
      @subject.respond_to?(@value)
    end
  end
end
