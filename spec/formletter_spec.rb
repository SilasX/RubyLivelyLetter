require '../lib/FormLetter.rb'

describe FormLetter do
  it "should make simple substitutions appropritately" do
    @fl1 = FormLetter.new('test_inputs/Template1.txt') 
    @fl1.generate_letter('test_inputs/subs1.yml').should == File.open('test_inputs/ExpOutput1.txt').read
  end
end
