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
      # @param site [Jekyll::Site] The site to generate for
      # @return [void]
      def generate(site)
        @site = site

        config = configuration(@site.source)
        configure_compass(config)
        puts "\rGenerating Compass: #{::Compass.configuration.sass_path}" +
                 " => #{::Compass.configuration.css_path}"
        unless File.exist? ::Compass.configuration.sass_dir
          print "      Generating... "
          return
        end

        ::Compass::Commands::UpdateProject.new(@site.config['source'], {:project_type => :jekyll}).execute

        puts
        print "      Generating... "
        nil
      end

      private

      # Compile a configuration Hash from sane defaults mixed with user input
      # from `_config.yml` as well as `_data/compass.yml`.
      #
      # @param source [String] The project source folder
      # @return [::Compass::Configuration::Data]
      def configuration(source)
        config = CompassConfiguration.default_configuration
        config[:project_path] = source
        config.extend(@site.config['compass'] || {})
        config.extend(@site.data['compass'] || {})
        config[:css_path] = File.join(@site.config['destination'], config[:css_dir]) unless config.has_key? :css_path
        config.to_compass
      end

      # Sets up event handlers with Compass and various other
      # configuration setup needs
      #
      # @param config [::Compass::Configuration::Data] Configuration to pass to Compass and Sass
      # @return [void]
      def configure_compass(config)
        ::Compass.add_configuration(config)

        ::Compass.configuration.on_stylesheet_saved(
            &method(:on_stylesheet_saved)
        )
        ::Compass.configuration.on_sprite_saved(
            &method(:on_sprite_saved)
        )
        ::Compass.configuration.on_sprite_removed(
            &method(:on_sprite_removed)
        )

        Dir["#{::Compass.configuration.css_path}/**/*"].each do |path|
          source = @site.config['destination']
          @site.static_files <<
              CompassFile.new(
                  @site,
                  source,
                  File.dirname(path)[source.length..-1],
                  File.basename(path)
              )
        end

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
    end
  end
end
