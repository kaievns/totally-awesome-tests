module Totes
  class Reporter
    def self.inst
      @inst ||= new
    end

    def reset
      @tests = 0
      @fails = []
      @time  = Time.new
      puts "Testing\n"
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
      prefix  = @fails.size == 0 ? "\e[32m✔︎ " : "\e[31m✖︎ "

      puts "\n\n#{prefix}Tests: %d, Failed: %d \e[0m\e[;2m(%.1f seconds, %.1f tests/sec)\e[0m\n" % [
        @tests, @fails.size, seconds, @tests / seconds
      ]

      print_failures
    end

  private

    def print_failures
      @fails.each do |error|
        puts "\n\e[31mERROR: #{error.message}\e[0m"
        error.backtrace.each do |line|
          puts " \e[;2m#{line.gsub Dir.pwd+"/", ""}\e[0m"
        end
      end
    end
  end
end
