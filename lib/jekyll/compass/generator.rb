
require 'sass/plugin'
require 'compass'
require 'compass/commands'
require 'fileutils'

module Jekyll
  module Compass
    # This is the main generator plugin for Jekyll. Jekyll finds these plugins
    # itself, we just need to be setup by the user as a gem plugin for their
    # website. The plugin will only do something if there is a `_sass` folder
    # in the source folder of the Jekyll website.
    class Generator < ::Jekyll::Generator
      safe true
      priority :high

      # This is the entry point to our plugin from Jekyll. We setup a compass
      # environment and force a full compilation directly into the Jekyll output
      # folder.
      #
      # @return void
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

      # Compile a configuration Hash from sane defaults mixed with user input
      # from `_config.yml` as well as `_data/compass.yml`.
      #
      # @param source [String] The project source folder
      # @param input_directory [String] The folder containing the Sass files
      # @param output_directory [String] The folder to output CSS files to
      # @return [Hash]
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
        config = deep_merge!(config, symbolize_keys(user_config)) if user_config
        user_data = @site.data['compass']
        config = deep_merge!(config, symbolize_keys(user_data)) if user_data

        config
      end

      # Sets up event handlers with Compass and various other
      # configuration setup needs
      #
      # @param config [Hash] Configuration to pass to Compass and Sass
      # @return [void]
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
        nil
      end

      # Event handler triggered when Compass creates a new stylesheet
      #
      # @param filename [String] The name of the created stylesheet.
      # @return [void]
      def on_stylesheet_saved(filename)
        source = @site.config['destination']
        @site.static_files <<
            CompassFile.new(
                @site,
                source,
                File.dirname(filename)[source.length..-1],
                File.basename(filename)
            )
        nil
      end

      # Event handler triggered when Compass creates a new sprite image
      #
      # @param filename [String] The name of the created image.
      # @return [void]
      def on_sprite_saved(filename)
        @site.static_files <<
            StaticFile.new(
                @site,
                @site.source,
                File.dirname(filename)[@site.source.length..-1],
                File.basename(filename)
            )
        nil
      end

      # Event handler triggered when Compass deletes a stylesheet
      #
      # @param filename [String] The name of the deleted stylesheet.
      # @return [void]
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
        nil
      end

      # Merges a target hash with another hash, recursively.
      #
      # @param target [Hash] The target hash
      # @param merge [Hash] The hash to merge into the target
      # @return [Hash] Returns the merged target
      def deep_merge!(target, merge)
        merge.keys.each do |key|
          if merge[key].is_a? Hash and target[key].is_a? Hash
            target[key] = deep_merge!(target[key], merge[key])
          else
            target[key] = merge[key]
          end
        end

        target
      end

      # Turn all String keys of a hash into symbols, and return in another Hash.
      #
      # @param hash [Hash] The hash to convert
      # @return [Hash] Returns the symbolized copy of hash.
      def symbolize_keys(hash)
        target = hash.dup

        keys.each do |key|
          self[(key.to_sym rescue key) || key] = delete(key)
        end

        target
      end
    end
  end
end
