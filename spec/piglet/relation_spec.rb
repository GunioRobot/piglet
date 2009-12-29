require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


describe Piglet::Relation do
  
  before do
    @relation = Object.new
    @relation.extend Piglet::Relation
  end
  
  it 'has a alias' do
    @relation.alias.should_not be_nil
  end
  
  it 'has a unique alias' do
    aliases = { }
    1000.times do
      @relation = Object.new
      @relation.extend Piglet::Relation
      aliases.should_not have_key(@relation.alias)
      aliases[@relation.alias] = @relation
    end
  end
  
  describe '#group' do
    it 'returns a new relation with the relation as source' do
      @relation.group(:a).source.should == @relation
    end
  end
  
end
