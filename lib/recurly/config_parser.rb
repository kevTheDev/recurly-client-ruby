require 'fileutils'
module Recurly
  module ConfigParser
    class << self

      def parse(environment='development', path = nil)
        path ||= Recurly.settings_path
        settings = {}
        if File.exists?(path)
          settings = YAML.load_file(path) || {}
        else
          puts "\n#{path} file not found. Run rake recurly:setup to create one\n\n"
        end

        settings[environment]
      end

      def save(settings = {}, path = nil)
        path ||= Recurly.settings_path
        FileUtils.mkdir_p(File.dirname(path))
        File.open(path, 'w' ) do |out|
          YAML.dump(settings, out)
        end
      end
    end
  end

end