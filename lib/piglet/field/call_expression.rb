module Piglet
  module Field
    class CallExpression # :nodoc:
      include Field
    
      def initialize(name, inner_expression, options=nil)
        options ||= {}
        @name, @inner_expression = name, inner_expression
        @new_name = options[:as]
      end
    
      def simple?
        false
      end
    
      def to_s
        "#{@name}(#{@inner_expression})"
      end
    end
  end
end