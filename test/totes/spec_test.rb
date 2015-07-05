describe Totes::Spec do
  spec = subject.new(1, &Proc.new{})

  describe spec.it do
    it.must be_a Totes::Query
  end

end
