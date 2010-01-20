require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Algebra::Restriction::Predicate#call' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ] ])
    @tuple  = Tuple.new(@header, [ 1 ])

    @predicate = PredicateSpecs::Object.new(@header[:id], 1)
  end

  subject { @predicate.call(@tuple) }

  it 'should send the left and right value to self.class.eval' do
    response = mock('#eval response')
    PredicateSpecs::Object.should_receive(:eval).with(1, 1).and_return(response)
    should equal(response)
  end
end
