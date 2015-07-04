module Totes
  class Runner
    def self.specs
      @specs ||= []
    end

    def self.start
      new.run(specs)
    end

    def initialize
    end

    def run(specs)
      specs.each do |spec|
        spec.instance_eval &spec.block
        run spec.specs
      end
    end
  end
end
