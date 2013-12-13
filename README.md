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

jekyll-compass is a jekyll plugin that provides an interface between Jekyll's building commands and the Compass
libraries to automatically build your Compass Sass files during a regular website build. This means your CSS files
end up directly in your `_site` output folder and never need to be checked into your version control.

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

Simply setup your SASS files in the `_sass` folder in your websites root folder. Then run `jekyll build` and watch the
magic.

Configuration
-------------

You may add a file to your `_data` folder called `compass.yml`. This will contain overrides for the compass
configuration, similar to the `config.rb` in a regular compass project. Any of the
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
