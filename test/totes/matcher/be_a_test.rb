describe Totes::Matcher::BeA do

  describe subject.new(String) do
    it.likes("string").must be true
    it.likes(['array']).must be false
  end

end
