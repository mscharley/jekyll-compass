
# This file serves as the main entry point for the plugin. We simply include
# all the various parts of the plugin so that everything just works.

# Jekyll is the static site builder that we are making a plugin for.
#
# @see http://jekyllrb.com/
module Jekyll
  # Sass is a set of extensions to CSS that allows for things like mixins
  # and variables. Compass is a library of Sass functions and code for use
  # with your own websites.
  #
  # @see http://sass-lang.com/
  # @see http://compass-style.org/
  module Compass
  end
end

require 'jekyll/compass/compass_file'
require 'jekyll/compass/core_ext'
require 'jekyll/compass/generator'
