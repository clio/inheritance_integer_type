require 'spec_helper'
require 'debugger'
describe InheritanceIntegerType do

  let(:base) { Base.create(name: "Hello") }
  let(:left) { LeftChild.create(name: "Hello") }
  let(:deep) { DeepChild.create(name: "Hello") }

  describe "The parent" do
    subject { base }
    it { is_expected.to be_persisted }
  end

  describe "The inherited classes" do
    subject { left }
    it { is_expected.to be_persisted }
    it { is_expected.to eql LeftChild.first }
  end

  describe "The deep inherited classes" do
    subject { deep }
    it { is_expected.to be_persisted }
    it { is_expected.to eql DeepChild.first }
  end

  describe "Belongs to associations" do

    let(:belong) { BelongsTo.create(base: base, left_child: left) }
    subject { belong }

    it "properly assocaites the base class" do
      expect(subject.base).to eql base
    end

    it "properly assocaites the children class" do
      expect(subject.left_child).to eql left
    end


  end

  describe "Has many associations" do
    let(:other) { Other.create }
    before do
      [base, left, deep].each{|a| a.update_attributes(other: other) }
    end
    subject { other }
    it "properly finds the classes through the association" do
      expect(other.bases).to match_array [base, left, deep]
    end

  end

end
