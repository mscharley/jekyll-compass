require 'yaml'

module Jekyll
  module Compass
    # Abstracts Compass's configuration away from any particular process in our plugin
    class CompassConfiguration
      CONFIGURATION_NAME = 'Jekyll::Compass'

      def extend(hash)
        hash.each do |key, value|
          self[key] = value
        end
      end

      def delete(key)
        @data.delete(key)
      end

      def has_key?(key)
        @data.has_key?(key)
      end

      def []=(key, value)
        key = key.to_sym unless key.is_a? Symbol
        value = value.to_sym if SYMBOL_VALUES.include? key

        if value.is_a? Hash
          value.each do |subkey, subvalue|
            subkey = subkey.to_sym unless subkey.is_a? Symbol
            @data[key][subkey] = subvalue
          end
        end

        @data[key] = value
      end

      def [](key)
        @data[key]
      end

      def to_compass
        ::Compass::Configuration::Data.new(CONFIGURATION_NAME, @data)
      end

      private

      SYMBOL_VALUES = [
          :project_type,
          :environment,
          :output_style,
          :preferred_syntax,
          :sprite_engine,
      ]

      def initialize(initial_hash = {})
        @data = initial_hash
      end

      class << self
        def default_configuration
          new({
              :default_project_type => :jekyll,
              :http_path => '/',
              :sass_dir => '_sass',
              :css_dir => 'css',
              :images_dir => 'images',
              :javascripts_dir => 'javascripts',
          })
        end

        def from_yaml_file(filename)
           config = default_configuration
          YAML.load_file(filename).each do |k, v|
            config[k.to_sym] = v
          end
          config
        end
      end
    end
  end
end
