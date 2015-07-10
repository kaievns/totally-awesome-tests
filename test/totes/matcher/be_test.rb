describe Totes::Matcher::Be do
  value   = "string"

  describe subject.new(value) do
    it.likes(value).must be true
    it.likes("other value").must be false
  end
  
end
