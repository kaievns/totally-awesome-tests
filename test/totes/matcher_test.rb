describe Totes::Matcher do

  describe subject.build(:be, Totes::Matcher) do
    it.must be_a Totes::Matcher::Be
  end

  describe subject.build("non_existing_matcher", "blah") do
    it.must be nil
  end

end
