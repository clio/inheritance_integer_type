require 'spec_helper'

describe InheritanceIntegerType do
  
  let(:base) { Base.create(name: "Hello") }
  let(:left) { LeftChild.create(name: "Hello") }

  describe "The parent" do
    subject { base }
    it { is_expected.to be_persisted }
  end

  describe "The inherited classes" do
    subject { left }
    it { is_expected.to be_persisted }
    it { is_expected.to eql LeftChild.first }
  end


end
