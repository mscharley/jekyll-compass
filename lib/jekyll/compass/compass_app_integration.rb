require 'compass/app_integration'
require 'jekyll/compass/compass_installer'

module Jekyll
  module Compass
    # Integration class to add a new project type to `compass create`
    class CompassAppIntegration
      def self.installer(*args)
        CompassInstaller.new(*args)
      end

      def self.configuration
        config = CompassConfiguration.default_configuration
        config[:css_dir] = "_site/#{config[:css_dir]}"
        ::Compass::Configuration::Data.new(CompassConfiguration::CONFIGURATION_NAME, config)
      end
    end
  end
end

# Register our project type with compass
Compass::AppIntegration.register(:jekyll, 'Jekyll::Compass::CompassAppIntegration')
