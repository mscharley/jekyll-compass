require 'compass/app_integration'
require 'jekyll/compass/compass_installer'

module Jekyll
  module Compass
    # Integration class to manage a new project type in Compass
    class CompassAppIntegration
      def self.installer(*args)
        CompassInstaller.new(*args)
      end

      def self.configuration
        project_path = ::Compass.configuration.project_path
        config_file = File.join(project_path, '_data/compass.yml')
        if File.exist? config_file
          config = CompassConfiguration.from_yaml_file config_file
          config[:css_dir] = "_site/#{config[:css_dir]}"
        else
          config = CompassConfiguration.default_configuration
        end
        config[:config_file] = config_file
        config.to_compass
      end
    end
  end
end

# Register our project type with compass
::Compass::AppIntegration.register(:jekyll, 'Jekyll::Compass::CompassAppIntegration')
