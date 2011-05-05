require 'spec_helper'

describe Guard::Gimli do
  subject { Guard::Gimli.new }

  describe "#initialize" do
    describe ":outputdir" do
      it "is nil by default" do
        subject = Guard::Gimli.new([])
        subject.options[:outputdir].should be_nil
      end

      it "can be set " do
        subject = Guard::Gimli.new([], { :outputdir => 'build' })
        subject.options[:outputdir].should == 'build'
      end
    end
  end

  describe "#start" do
    it "creates refresher with default options" do
      subject = Guard::Gimli.new([])
      mock(Guard::Gimli::Refresher).new(:outputdir => nil)
      subject.start
    end

    it "creates reactor with given options" do
      subject = Guard::Gimli.new([], { :outputdir => 'build' })
      mock(Guard::Gimli::Refresher).new(:outputdir => 'build')
      subject.start
    end
  end

  describe "#run_on_change" do
    it "converts pdfs" do
      refresher = Guard::Gimli::Refresher.new({})
      mock(subject).refresher { refresher }
      mock(refresher).reload(['foo'])
      subject.run_on_change(['foo'])
    end
  end
end

