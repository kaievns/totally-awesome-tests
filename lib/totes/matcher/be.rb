module Totes
  class Matcher::Be < Totes::Matcher
    error_must "expected %{subject} to be the same as %{value}"
    error_wont "expected %{subject} not to be the same as %{value}"

    def likes(subject)
      subject === @value
    end
  end
end
