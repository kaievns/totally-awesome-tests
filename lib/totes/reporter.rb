module Totes
  class Reporter
    def self.inst
      @inst ||= new
    end

    def reset
      @tests = 0
      @fails = []
      @time  = Time.new
      puts "Running tests...\n\n"
    end

    def passed(query)
      @tests += 1
      print "\e[32m.\e[0m"
    end

    def failed(error)
      @tests += 1
      @fails << error
      print "\e[31mF\e[0m"
    end

    def summary
      seconds = Time.new - @time
      # ✔︎
      # ✖︎
      puts "\n\nTests: %d, Failed: %d (%.1f seconds, %.1f tests/sec)\n" % [
        @tests, @fails.size, seconds, @tests / seconds
      ]
    end
  end
end
