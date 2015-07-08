module Totes
  class Runner
    def self.specs
      @specs ||= []
    end

    def self.start
      new(specs).run
    end

    def initialize(specs)
      @specs = specs
      Totes::Reporter.inst.reset
    end

    def run
      exec @specs
      Totes::Reporter.inst.summary
    end

    def exec(specs)
      specs.each do |spec|
        spec.instance_eval &spec.block
        exec spec.specs
      end
    end
  end
end
