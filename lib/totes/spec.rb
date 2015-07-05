module Totes
  class Spec
    attr_reader :subject, :block, :specs

    def initialize(*args, &block)
      @subject = find_subject(*args)
      @block   = block
      @specs   = []
    end

    def describe(*args, &block)
      @specs << self.class.new(*args, &block)
    end

    # returns the _subject_ query object
    def it
      Totes::Query.new(@subject)
    end

    # builds the matchers
    def method_missing(*args, &block)
      Totes::Matcher.build(*args, &block) || super(*args, &block)
    end

  private

    def find_subject(*args)
      return args[0] # TODO make it smarter
    end
  end
end
