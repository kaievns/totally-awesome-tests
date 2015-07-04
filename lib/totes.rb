module Totes
  autoload :VERSION,  "totes/version"
  autoload :Runner,   "totes/runner"
  autoload :Resolver, "totes/resolver"
  autoload :Cli,      "totes/cli"
end

require_relative "./totes/kernel"
