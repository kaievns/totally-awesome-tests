module Totes
  class Cli
    def initialize(args)
      sources = parse_args(args)

      add_to_load_path('lib', 'test')
      require_relative "./autorun"
      require_all sources
    end

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

    def add_to_load_path(*dirs)
      dirs.each do |dir|
        if File.exists?(dir) && File.directory?(dir)
          $LOAD_PATH << "#{Dir.pwd}/#{dir}/"
        end
      end
    end

    def require_all(sources)
      Dir[*clean_dirs_list(sources)].each do |filename|
        require "#{Dir.pwd}/#{filename}"
      end
    end

    def clean_dirs_list(sources)
      sources = ['test'] if sources.empty?

      sources.map do |name|
        name = name.slice(0, name.size - 1) if name[name.size-1] == '/'
        File.exists?(name) && File.directory?(name) ? "#{name}/**/*_test.rb" : name
      end
    end
  end
end
