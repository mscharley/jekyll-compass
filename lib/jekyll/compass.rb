
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

# Require dependencies
require 'jekyll'
require 'sass/plugin'
require 'compass'
require 'compass/commands'

# Internal requires
%w{compass_configuration compass_file generator compass_app_integration}.each do |f|
  require "jekyll/compass/#{f}"
end
