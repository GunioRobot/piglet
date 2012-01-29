# encoding: utf-8

module Piglet
  module Field
    class BinaryConditional
      include Field

      def initialize(test, if_true, if_false)
        @test, @if_true, @if_false = test, if_true, if_false
        @type = expression_type(@if_true)
      end

      def to_s
        "(#{@test} ? #{@if_true} : #{@if_false})"
      end
    end
  end
end