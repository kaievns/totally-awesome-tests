module Totes
  class Totes::Matcher::BeAnything
    def initialize(method_name, *args, &block)
      @method = method_name =~ /\?$/ ? method_name : "#{method_name}?"
      @args   = args
      @block  = block
    end

    def likes(subject)
      subject.__send__ @method, *@args, &@block
    end
  end
end
