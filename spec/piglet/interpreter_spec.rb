# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


describe Piglet::Interpreter do

  before do
    @interpreter = Piglet::Interpreter.new
  end

  context 'basic usage' do
    it 'interprets a block given to #new so that a subsequent call to #to_pig_latin returns the Pig Latin code' do
      output = Piglet::Interpreter.new { store(load('some/path'), 'out') }
      output.to_pig_latin.should_not be_empty
    end

    it 'interprets a block given to #interpret so that a subsequent call to #to_pig_latin returns the Pig Latin code' do
      output = @interpreter.interpret { store(load('some/path'), 'out') }
      output.to_pig_latin.should_not be_empty
    end

    it 'interprets a block given to #to_pig_latin and returns the Pig Latin code' do
      @interpreter.to_pig_latin { store(load('some/path'), 'out') }.should_not be_empty
    end

    it 'does nothing with no commands' do
      @interpreter.interpret.to_pig_latin.should be_empty
    end
  end

  describe '#test' do
    it 'outputs a binary conditional' do
      @interpreter.interpret do
        dump(load('in').foreach { [test(self.a == self.b, self.a, self.b)]})
      end
      @interpreter.to_pig_latin.should include('(a == b ? a : b)')
    end
  end

  describe '#literal' do
    it 'outputs a literal string' do
      @interpreter.interpret do
        dump(load('in').foreach { [literal('hello').as(:world)]})
      end
      @interpreter.to_pig_latin.should include("'hello' AS world")
    end

    it 'outputs a literal integer' do
      @interpreter.interpret do
        dump(load('in').foreach { [literal(3).as(:n)]})
      end
      @interpreter.to_pig_latin.should include("3 AS n")
    end

    it 'outputs a literal float' do
      @interpreter.interpret do
        dump(load('in').foreach { [literal(3.14).as(:pi)]})
      end
      @interpreter.to_pig_latin.should include("3.14 AS pi")
    end

    it 'outputs a literal string when passed an arbitrary object' do
      @interpreter.interpret do
        dump(load('in').foreach { [literal(self).as(:interpreter)]})
      end
      @interpreter.to_pig_latin.should match(/'[^']+' AS interpreter/)
    end

    it 'escapes single quotes' do
      @interpreter.interpret do
        dump(load('in').foreach { [literal("hello 'world'").as(:str)]})
      end
      @interpreter.to_pig_latin.should include("'hello \\'world\\'' AS str")
    end
  end

end
