require 'yaml'
class FormLetter
  def initialize template_file
    @template = File.open(template_file).read
  end

  def generate_letter input
    subs = YAML::load(File.open(input))
    letter = @template
    subs.each do |k,v|
      replacement = v
      if v.class == Array
        replacement = v.sample
      end
      letter.gsub!("#"+k, replacement)
    end
    @final_letter = letter
    letter
  end
end
