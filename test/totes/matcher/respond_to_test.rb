describe Totes::Matcher::RespondTo do

  describe subject.new("empty?") do
    it.likes("string").must be true
    it.likes(Class).must be false
  end

end
