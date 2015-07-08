describe Totes::Matcher::RespondTo do
  matcher = subject.new("empty?")

  describe matcher.likes("string") do
    it.must be true
  end

  describe matcher.likes(boolean = false) do
    it.must be false
  end
end
