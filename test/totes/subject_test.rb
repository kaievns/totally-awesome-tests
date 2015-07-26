describe Totes::Subject do
  describe subject.new("string") do
    it.must be_a String
    it.must respond_to :size
    its.size.must  eq 6
    its.class.must eq String
  end
end
