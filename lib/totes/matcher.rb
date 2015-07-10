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

    def self.error_must(template=nil)
      template ? (@error_must = template) : @error_must
    end

    def self.error_wont(template=nil)
      template ? (@error_wont = template) : @error_wont
    end

    def initialize(value)
      @value = value
    end

    def test(subject, fail_on: false)
      if likes(subject) == fail_on
        fail(subject, positive: !fail_on)
      end
    end

    def likes(subject)
      raise "#{self.class.name}#likes(subject) is not implemented yet"
    end

  private

    def fail(subject, positive: true)
      super Totes::Error, build_error(subject, positive)
    end

    def build_error(subject, positive)
      template = positive ? self.class.error_must : self.class.error_wont
      template % {subject: subject.inspect}.merge(find_params_in(template))
    end

    def find_params_in(template)
      {}.tap do |params|
        template.scan(/%\{(.+?)\}/).each do |match|
          var_name = match[0].to_sym

          if instance_variable_defined?("@#{var_name}")
            params[var_name] = instance_variable_get("@#{var_name}").inspect
          end
        end
      end
    end
  end
end
