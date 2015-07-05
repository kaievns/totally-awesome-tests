describe Totes::Matcher::Be do
  value   = "string"
  matcher = subject.new(value)

  describe matcher.likes(value) do
    it.must be true
  end

  describe matcher.likes("other value") do
    it.must be false
  end

end
