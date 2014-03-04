
module Jekyll
  module Compass
    # This seemed to be necessary at the time, however I'm not sure now if it
    # is or not. (very) minor performance boost.
    class CompassFile < StaticFile
      # Write the static file. Since this class is used to represent files that
      # are purely conceptual we short-circuit to the inevitable failure.
      #
      # @return [boolean] false
      def write(destination)
        # Short-circuit to the inevitable
        false
      end
    end
  end
end
