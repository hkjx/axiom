require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::DirectionSet#reverse' do
  before do
    @attribute1 = Attribute::Integer.new(:id)
    @attribute2 = Attribute::String.new(:name)
    @directions = Relation::Operation::Order::DirectionSet.new([ @attribute1, @attribute2 ])
  end

  subject { @directions.reverse }

  it { should be_kind_of(Relation::Operation::Order::DirectionSet) }

  it 'should reverse each direction' do
    should == [ @attribute1.desc, @attribute2.desc ]
  end

  it 'should not reverse the attribute order' do
    subject.attributes.should == [ @attribute1, @attribute2 ]
  end
end