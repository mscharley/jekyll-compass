
module Jekyll
  module Compass
    class CompassFile < StaticFile
      def write(destination)
        # Short-circuit to the inevitable
        false
      end
    end
  end
end