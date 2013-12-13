
module Jekyll
  module Compass
    # This seemed to be necessary at the time, however I'm not sure now if it
    # is or not. (very) minor performance boost.
    class CompassFile < StaticFile
      def write(destination)
        # Short-circuit to the inevitable
        false
      end
    end
  end
end