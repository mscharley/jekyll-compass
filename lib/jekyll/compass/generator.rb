
require 'sass/plugin'
require 'compass'
require 'compass/commands'
require 'fileutils'

module Jekyll
  module Compass
    class Generator < ::Jekyll::Generator
      safe true
      priority :high

      def generate(site)
        @site = site
        input_directory = File.join(@site.source, '_sass')

        return unless File.exist? input_directory
        puts

        config = configuration(
            @site.source,
            input_directory,
            File.join(@site.config['destination'], 'css')
        )
        configure_compass(config)

        ::Compass::Commands::UpdateProject.new(site.config['source'], config).
            execute
        nil
      end

      private

      def configuration(source, input_directory, output_directory)
        config = {
            :project_path => source,
            :http_path => '/',
            :sass_path => input_directory,
            :css_path => output_directory,
            :images_path => File.join(source, 'images'),
            :javascripts_path => File.join(source, 'js'),
            :environment => :production,
            :output_style => :compact,
            :force => true,
        }

        user_config = @site.config['compass']
        config.deep_merge!(user_config.symbolize_keys) if user_config
        user_data = @site.data['compass']
        config.deep_merge!(user_data.symbolize_keys) if user_data

        config
      end

      def configure_compass(config)
        ::Compass.add_configuration(config, 'Jekyll::Compass')

        ::Compass.configuration.on_stylesheet_saved(
            &method(:on_stylesheet_saved)
        )
        ::Compass.configuration.on_sprite_saved(
            &method(:on_sprite_saved)
        )
        ::Compass.configuration.on_sprite_removed(
            &method(:on_sprite_removed)
        )
      end

      def on_stylesheet_saved(filename)
        source = @site.config['destination']
        @site.static_files <<
            CompassFile.new(
                @site,
                source,
                File.dirname(filename)[source.length..-1],
                File.basename(filename)
            )
      end

      def on_sprite_saved(filename)
        @site.static_files <<
            StaticFile.new(
                @site,
                @site.source,
                File.dirname(filename)[@site.source.length..-1],
                File.basename(filename)
            )
      end

      def on_sprite_removed(filename)
        @site.static_files = @site.static_files.select do |p|
          if p.path == filename
            sprite_output = p.destination(@site.config['destination'])
            File.delete sprite_output if File.exist? sprite_output
            false
          else
            true
          end
        end
      end
    end
  end
end
