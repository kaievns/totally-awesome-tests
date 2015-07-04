#
# The standard autorun hook
#

test_helper_file = File.join(Dir.pwd, "test/test_helper.rb")
require test_helper_file if File.exists?(test_helper_file)

at_exit { Totes::Runner.start }
