require 'spec_helper'
require 'debugger'
describe InheritanceIntegerType do

  let(:base) { Base.create(name: "Hello") }
  let(:left) { LeftChild.create(name: "Hello") }
  let(:deep) { DeepChild.create(name: "Hello") }

  describe "The parent" do
    subject { base }
    it { is_expected.to be_persisted }
    it "has no type" do
      expect(subject.type).to be_nil
    end
    it { is_expected.to eql Base.first }
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

  describe "Old style inheritance" do

    let(:old_style) { OldStyle.create }
    let(:inherited_old_style) { InheritOldStyle.create }

    context "on the base class" do
      subject { old_style }
      it "has no type" do
        expect(subject.type).to be_nil
      end
      it { is_expected.to eql OldStyle.first }
    end

    context "on the inherited class" do
      subject { inherited_old_style }
      it "has the string type" do
        expect(inherited_old_style.type).to eql "InheritOldStyle"
      end
      it { is_expected.to eql InheritOldStyle.first }
    end

  end

end
