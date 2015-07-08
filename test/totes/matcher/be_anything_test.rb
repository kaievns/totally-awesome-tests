describe Totes::Matcher::BeAnything do
  matcher = subject.new("empty")

  describe matcher.likes("") do
    it.must be true
  end

  describe matcher.likes("something") do
    it.must be false
  end
end
