module Totes
  class Matcher::BeA < Totes::Matcher
    error_must "expected %{subject} to be an instance of %{value}"
    error_wont "expected %{subject} not to be an instance of %{value}"

    def likes(subject)
      subject.is_a?(@value)
    end
  end
end
