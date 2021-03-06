# encoding: utf-8

module Piglet
  module Field
    class Rename # :nodoc:
      attr_reader :name, :type, :predecessors
      
      def initialize(name, field_expression)
        @name, @field_expression, @type = name, field_expression, field_expression.type
        @predecessors = [field_expression]
      end
      
      def to_s(inner=false)
        expr = if inner then @field_expression.field_alias else @field_expression end
        "#{expr} AS #{@name}"
      end
    end
  end
end