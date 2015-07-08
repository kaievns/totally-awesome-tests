describe Totes::Matcher::BeA do
  matcher = subject.new(String)

  describe matcher.likes("string") do
    it.must be true
  end

  describe matcher.likes(['array']) do
    it.must be false
  end
end
