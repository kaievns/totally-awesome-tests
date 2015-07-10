module Totes
  module Backtrace
    #
    # Filters the backtrace on an error
    #
    def self.filter(error)
      error.set_backtrace error.backtrace.map { |line|
        unless line =~ /totally-awesome-tests\/lib\/totes\/[a-z_]+\.rb/
          line.gsub! /:in `block.+?$/, ""
        end
      }.compact
    end
  end
end
