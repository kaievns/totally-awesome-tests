module Totes
  class Totes::Matcher::BeAnything < Totes::Matcher
    error_must "expected %{subject}#%{method} to be true, instead have %{result}"
    error_wont "expected %{subject}#%{method} to be false, instead have %{result}"

    def initialize(method_name, *args, &block)
      @method = method_name =~ /\?$/ ? method_name : "#{method_name}?"
      @args   = args
      @block  = block
    end

    def likes(subject)
      @result = subject.__send__ @method, *@args, &@block
    end
  end
end
