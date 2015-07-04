module Totes
  class Cli
    def initialize(args)
      sources = parse_args(args)

      require_relative "./autorun"
      Totes::Resolver.new(sources).require_all
    end

  private

    def parse_args(args)
      [].tap do |sources|
        while arg = args.shift
          case arg
          when '-h', '--help' then print_help
          else sources << arg
          end
        end
      end
    end

    def print_help
      puts "totes [source...]"
      exit
    end


  end
end
