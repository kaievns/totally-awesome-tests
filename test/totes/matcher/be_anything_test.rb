describe Totes::Matcher::BeAnything do

  describe subject.new("empty") do
    it.likes("").must be true
    it.likes("something").must be false
  end

end
