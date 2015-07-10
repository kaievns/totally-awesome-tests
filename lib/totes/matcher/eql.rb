module Totes
  class Matcher::Eql < Totes::Matcher
    error_must "expected %{subject} to be equal %{value}"
    error_wont "expected %{subject} not to be equal %{value}"

    def likes(subject)
      # TODO make a deep matching thing work
      subject == @value
    end
  end
end
