describe Totes::Matcher::Eql do

  describe subject.new("nikolay") do
    it.likes("nikolay").must be true
    it.likes("vladimir").must be false
  end

end
