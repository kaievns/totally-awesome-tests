#
# This is a completely stripped down base class
#
module Totes
  class Noop
    Class.new.instance_methods.each do |core_method|
      define_method core_method do |*args, &block|
        method_missing core_method, *args, &block
      end
    end
  end
end
