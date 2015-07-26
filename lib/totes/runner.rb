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
      @specs.each { |spec| loop_through spec }
      Totes::Reporter.inst.summary
    rescue StandardError => e
      Totes::Backtrace.filter e
      raise e
    end

  private

    def loop_through(spec)
      exec [spec]
    rescue Totes::Spec::StartOver => e
      spec.instance_eval { @__count[:queries] = 0; @__specs = [] } # resetting the state
      loop_through(spec)
    end

    def exec(specs)
      specs.each do |spec|
        spec.instance_eval &spec.instance_variable_get("@__block")
        exec spec.instance_variable_get("@__specs")
      end
    end
  end
end
