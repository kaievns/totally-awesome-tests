describe Totes::Matcher do

  describe subject.new(1) do
    it.must respond_to(:must)
    it.must respond_to(:wont)
  end

end
