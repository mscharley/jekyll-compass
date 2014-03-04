
module Jekyll
  module Compass
    # Abstracts Compass's configuration away from any particular process in our plugin
    class CompassConfiguration
      CONFIGURATION_NAME = 'Jekyll::Compass'

      def self.default_configuration
        @default_configuration ||= {
            :default_project_type => :jekyll,
            :http_path => '/',
            :sass_dir => '_sass',
            :css_dir => 'css',
            :images_dir => 'images',
            :javascripts_dir => 'js',
            :environment => :production,
            :force => true,
        }
      end
    end
  end
end
