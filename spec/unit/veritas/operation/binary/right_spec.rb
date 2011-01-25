require 'spec_helper'

describe 'Veritas::Operation::Binary#right' do
  subject { object.right }

  let(:klass)  { Class.new { include Operation::Binary } }
  let(:left)   { 'Left'                                  }
  let(:object) { klass.new(left, right)                  }

  context 'when right operand is frozen' do
    let(:right) { 'Right'.freeze }

    it { should equal(right) }
  end

  context 'when right operand is not frozen' do
    let(:right) { 'Right' }

    it { should_not equal(right) }

    it { should be_frozen }

    it { should == right }
  end
end
