module Kernel
  # the top level `describe` blocks
  def describe(*args, &block)
    Totes::Runner.specs << Totes::Spec.new(*args, &block)
  end
end
