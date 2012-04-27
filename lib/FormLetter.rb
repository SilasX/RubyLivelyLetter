require 'yaml'
class FormLetter
  def initialize template_file, subs_flag = '#'
    @template = File.open(template_file).read
    @output_letter = @template
    @subs_flag = subs_flag # string used to indicate word to be substituted
  end

  # this makes the "simple" (static) substitutions from the "input" YAML file
  # you have defined
  def simple_subs input
    subs = YAML::load(File.open(input))
    letter = @output_letter
    subs.each do |k,v|
      replacement = v
      if v.class == Array
        replacement = v.sample
      end
      letter.gsub!(@subs_flag + k, replacement)
    end
    @output_letter = letter
    letter
  end

  # given an instance of a class (object), and an array of methods on that object,
  # then for each method M in the list, replace #M in the template with object.M
  # If you want to substitute a string other than M, use a hash (rather than an
  # array), mapping methods to the string in the template it should replace
  # (methods must be given as symbols or strings)
  def object_subs object, method_list
    letter = @output_letter
    #puts "object_subs received a/n #{method_list.class}, namely #{method_list}"
    case method_list
    when Array
      method_list.each do |method|
        letter.gsub!(@subs_flag + method.to_s, object.send(method.intern) )
      end
    when Hash
      method_list.each do |method, template_string|
        letter.gsub!(@subs_flag + template_string.to_s, object.send(method.intern) )
      end
    else
      puts "Alright, I don't even know what to do with that method spec ... I give up."
      return "Error -- invalid method array/hash"
    end
    @output_letter = letter
    letter
  end
end
