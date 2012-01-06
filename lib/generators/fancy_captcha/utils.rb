module FancyCaptcha
  module Generators
    module Utils
      module InstanceMethods
        def display(output, color = :green)
          say("           -  #{output}", color)
        end
      end
    end
  end
end

