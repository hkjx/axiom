require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Relation::Operation::Binary#optimize' do
  subject { binary_operation.optimize }

  let(:klass)            { Class.new(BinaryRelationOperationSpecs::Object)  }
  let(:left_body)        { [ [ 1 ] ]                                        }
  let(:right_body)       { [ [ 'Dan Kubb' ] ]                               }
  let(:original_left)    { Relation.new([ [ :id,   Integer ] ], left_body)  }
  let(:original_right)   { Relation.new([ [ :name, String  ] ], right_body) }
  let(:binary_operation) { klass.new(left, right)                           }

  context 'containing optimized relations' do
    let(:left)  { original_left  }
    let(:right) { original_right }

    it 'delegates to super, but no #optimize in superclass' do
      expect { subject }.to raise_error(NoMethodError)
    end
  end

  context 'containing optimizable relations' do
    let(:left)  { original_left.project(original_left.header)   }
    let(:right) { original_right.project(original_right.header) }

    add_method_missing

    it { should_not equal(binary_operation) }

    it { should_not eql(klass.new(left, right)) }

    it { should eql(klass.new(left.optimize, right.optimize)) }

    it 'does not execute left_body#each' do
      left_body.should_not_receive(:each)
      subject
    end

    it 'does not execute right_body#each' do
      right_body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end
end
