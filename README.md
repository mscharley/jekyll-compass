jekyll-compass: Compass generator for Jekyll websites
=====================================================

**GitHub:** https://github.com/mscharley/jekyll-compass  
**Author:** Matthew Scharley  
**Contributors:** [See contributors on GitHub][gh-contrib]  
**Bugs/Support:** [Github Issues][gh-issues]  
**Copyright:** 2013  
**License:** [MIT license][license]

Synopsis
--------

jekyll-compass is a plugin for both jekyll and compass that provides an bi-directional interface between the two
applications, tightly integrating them and allowing each to work well when used directly.

Installation
------------

This plugin has a very simple two step install:

1.  Install the gem:

        gem install jekyll-compass

2.  Add the gem to your jekyll website's `_config.yml` file:

        gems:
        - jekyll-compass

Usage
-----

You may use compass to generate a layout and configuration for you. The site root is the folder where your `_config.yml`
lives.

    compass create -r jekyll-compass --app=jekyll path/to/site/root

Other `compass` commands will work as per usual, however you will need to add the `-r jekyll-compass --app=jekyll`
parameters to make sure `compass` can find the files from this plugin that it needs. If you forget these parameters
then Compass will fail with an error message as it won't understand the project layout.

    # Compiles all your Sass/Compass into the _site folder, you may also specify --css-path on the command line
    compass compile -r jekyll-compass --app=jekyll
    compass watch -r jekyll-compass --app=jekyll

You will also note that Compass will build your Sass files whenever jekyll builds the rest of your website, ensuring
that what you publish is always up to date.

    # Compiles your entire website, including Sass/Compass
    jekyll build
    jekyll serve

Configuration
-------------

You may add a file to your `_data` folder called `compass.yml`. This will contain overrides for the compass
configuration, similar to the `config.rb` in a regular compass project. If you generated a layout using compass above
then this file will already exist with some default settings setup for you. Any of the
[regular configuration properties][compass-props] should be supported via the YAML file.

Compass also provides a way to pass through options directly to Sass via the `sass_options` option. You can find
details of what options are available from Sass in the [Sass Reference][sass-props].

An example configuration file might look like the following:

    output_style: compact
    sass_options:
      unix_newlines: true



  [license]: https://raw.github.com/mscharley/jekyll-compass/master/LICENSE
  [gh-contrib]: https://github.com/mscharley/jekyll-compass/graphs/contributors
  [gh-issues]: https://github.com/mscharley/jekyll-compass/issues

  [compass-props]: http://compass-style.org/help/tutorials/configuration-reference/
  [sass-props]: http://sass-lang.com/documentation/file.SASS_REFERENCE.html#options
