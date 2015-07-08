module Totes
  class Totes::Matcher::RespondTo < Totes::Matcher
    error_must "expected %{subject} to have method '%{value}', but it ain't have one"
    error_wont "expected %{subject} not to have method '%{value}', but it got one"

    def likes(subject)
      subject.respond_to?(@value)
    end
  end
end
