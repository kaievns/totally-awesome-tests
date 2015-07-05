module Totes
  class Matcher
    dir = File.dirname(__FILE__)

    autoload :Be,         "#{dir}/matcher/be"
    autoload :BeA,        "#{dir}/matcher/be_a"
    autoload :Eql,        "#{dir}/matcher/eql"
    autoload :RespondTo,  "#{dir}/matcher/respond_to"
    autoload :BeAnything, "#{dir}/matcher/be_anything"

    ALIASES = {
      eq:    "eql",
      be_an: "be_a"
    }

    def self.build(name, *args, &block)
      name  = ALIASES[name.to_sym] || name.to_s
      klass = name.gsub(/(\A|_)([a-z])/){ $2.upcase }
      klass = const_get(klass) rescue nil

      if !klass && name =~ /^be_[a-z]/
        klass = BeAnything
        args.unshift name.gsub(/^be_/, "")
      end

      klass && klass.new(*args, &block)
    end

    def initialize(value)
      @value = value
    end

    def likes(subject)
      fail "#{self.class.name}#likes is not implemented"
    end

    def failure(positive=true)
      fail "#{self.class.name}#failure is not implemented"
    end
  end
end
