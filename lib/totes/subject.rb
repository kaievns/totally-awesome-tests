#
# This is a smarty pants wrapper around the subject values
#
module Totes
  class Subject < Noop
    def initialize(subject)
      @subject = subject
    end

    def method_missing(name, *args, &block)
      # puts "#{name.inspect}(#{args.map(&:inspect).join(",")})"
      @subject.__send__ name, *args, &block
    end
  end
end
