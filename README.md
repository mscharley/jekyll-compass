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

jekyll-compass is a plugin for both Jekyll and Compass that provides a bi-directional interface between the two
applications, tightly integrating them and allowing each to work well together when either is used directly. In short,
if you use Compass as well as Jekyll, jekyll-compass makes your life easier.

Installation
------------

This plugin has a very simple two step install:

1.  Install the gem:

        $ gem install jekyll-compass

2.  Add the gem to your jekyll website's `_config.yml` file:

        gems:
        - jekyll-compass

Usage
-----

You may use Compass to generate a layout and configuration for you. The site root is the folder where your `_config.yml`
lives. This step is highly recommended as it will also install some plumbing to help Compass work correctly with your
new jekyll-compass project. You can also install your favourite framework directly, just remember to add the extra
parameters so that Compass understands the target project structure.

    compass create -r jekyll-compass --app=jekyll path/to/site/root
    compass create -r jekyll-compass --app=jekyll -r zurb-foundation path/to/site/root

If you are coming from an older version of jekyll-compass and just want to install the plumbing for Compass then use
this command:

    compass init jekyll -r jekyll-compass --prepare [path/to/site/root]

Other `compass` commands will then work as per usual:

    # Compiles all your Sass/Compass into the _site folder, or you may also specify --css-path on the command line
    compass compile
    compass watch

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
[regular configuration properties][compass-props] should be supported via this YAML file.

Compass also provides a way to pass through options directly to Sass via the `sass_options` option. You can find
details of what options are available from Sass in the [Sass Reference][sass-props].

An example configuration file might look like the following:

    output_style: compact
    sass_options:
      unix_newlines: true

In order to use other plugins for compass, add them to the `require` key in your `compass.yml` file. There is also a
`load` and `discover` key which map to the relevant commands in Compass' regular configuration file.

    require:
    - zurb-foundation

There is also a `import_paths` key which is analogous to the `add_import_path` line in `config.rb`.

    import_paths:
    - assets/foundation/scss

  [license]: https://raw.github.com/mscharley/jekyll-compass/master/LICENSE
  [gh-contrib]: https://github.com/mscharley/jekyll-compass/graphs/contributors
  [gh-issues]: https://github.com/mscharley/jekyll-compass/issues

  [compass-props]: http://compass-style.org/help/tutorials/configuration-reference/
  [sass-props]: http://sass-lang.com/documentation/file.SASS_REFERENCE.html#options
