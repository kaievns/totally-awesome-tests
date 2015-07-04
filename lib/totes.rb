module Totes
  autoload :VERSION,  "totes/version"
  autoload :Cli,      "totes/cli"
  autoload :Resolver, "totes/resolver"
  autoload :Runner,   "totes/runner"
  autoload :Spec,     "totes/spec"
  autoload :Matcher,  "totes/matcher"
end

require_relative "./totes/kernel"
