input = 'test_inputs/'
require '../lib/FormLetter.rb'
require input + 'DummyClass.rb'

describe FormLetter do
  it "should make simple substitutions appropritately" do
    @fl1 = FormLetter.new(input + 'Template1.txt') 
    @fl1.simple_subs(input + 'subs1.yml').should == File.open(input + 'ExpOutput1.txt').read
  end
  describe "object substitutions" do
    it "should make substitutions based on an ARRAY of object's public methods" do
      @dc1 = DummyClass.new
      @fl2 = FormLetter.new(input + 'Template2.txt') 
      @fl2.object_subs(@dc1,[:a,:test]).should == File.open(input + 'ExpOutput2.txt').read
    end

    it "should allow an argument list instead of an array" do
      @dc3 = DummyClass.new
      @fl4 = FormLetter.new(input + 'Template2.txt')
      @fl4.object_subs(@dc1,:a,:test).should == File.open(input + 'ExpOutput2.txt').read
    end

    it "should make substitutions based on a HASH mapping object's methods to template keyword" do
      @dc2 = DummyClass.new
      @fl3 = FormLetter.new(input + 'Template3.txt')
      @fl3.object_subs(@dc2,{:a => "firstfield", :test => "secondfield"}).should == File.open(input + 'ExpOutput2.txt').read
    end
    
  end
end
