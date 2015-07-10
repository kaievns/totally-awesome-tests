module Totes
  dir = File.dirname(__FILE__)

  autoload :VERSION,   "#{dir}/totes/version"
  autoload :Cli,       "#{dir}/totes/cli"
  autoload :Resolver,  "#{dir}/totes/resolver"
  autoload :Runner,    "#{dir}/totes/runner"
  autoload :Spec,      "#{dir}/totes/spec"
  autoload :Matcher,   "#{dir}/totes/matcher"
  autoload :Query,     "#{dir}/totes/query"
  autoload :Error,     "#{dir}/totes/error"
  autoload :Reporter,  "#{dir}/totes/reporter"
  autoload :Backtrace, "#{dir}/totes/backtrace"
end

require_relative "./totes/kernel"
