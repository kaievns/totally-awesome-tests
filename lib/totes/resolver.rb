# Finds all the test files and requires all everything
module Totes
  class Resolver
    def initialize(sources)
      @sources = sources
    end

    def require_all
      add_to_load_path('lib', 'test')
      require_spec_helpers

      Dir[*clean_dirs_list].each do |filename|
        require "#{Dir.pwd}/#{filename}"
      end
    end

  private

    def add_to_load_path(*dirs)
      dirs.each do |dir|
        if File.exists?(dir) && File.directory?(dir)
          $LOAD_PATH << "#{Dir.pwd}/#{dir}/"
        end
      end
    end

    def require_spec_helpers
      test_helper_file = File.join(Dir.pwd, "test/test_helper.rb")
      require test_helper_file if File.exists?(test_helper_file)
    end

    def clean_dirs_list
      @sources = ['test'] if @sources.empty?

      @sources.map do |name|
        name = name.slice(0, name.size - 1) if name[name.size-1] == '/'
        File.exists?(name) && File.directory?(name) ? "#{name}/**/*_test.rb" : name
      end
    end
  end
end
