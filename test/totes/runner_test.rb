describe Totes::Runner do

  describe subject.specs do
    it.must be_an Array
    it.wont be_empty
  end

end
