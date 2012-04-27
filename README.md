#### LivelyLetter
This is a system for making form letters with more variety, realism, and a human touch.  So far, it can do the following things:

##### Simple Substitutions from YAML
Given:
a) an input file template, and  
b) a yaml file with the substitutions you want to make into the letter template,
				
output a form letter with substitutions from the yaml file. The YAML entries can be arrays, in which case it makes the substitution with a randomly-chosen member of the array.

In your input form letter template, place a # before every variable you want to substitute from the yaml, and then ensure it is replaced with a (#-free) entry with the same key in your YAML file. For example, if you have #name, in your form letter, make sure you have a line like 

    name: Bobby

somewhere in your YAML file.

##### Substitutions based on a object's public methods and instance variables
Given:
a) an input file template,  
b) an object with public methods and/or instance variables, and  
c) an array of the methods you want to substitute into the form letter, 

output a form letter that replaces every occurrence of e.g. #method in the form letter with the result of calling object.method.  For example, if you have the class:
```ruby
class DummyClass
  attr_reader :a
  def initialize
    @a = "asdf"
  end
  def test
    "fdsa"
  end
end
```

And declare the variables

```ruby
fl = FormLetter.new
dc = DummyClass.new
template = "foo #a bar #test"
method_list = [:a, :test]
```
then calling

```ruby
fl.obj_sub(dc,method_list)
```
will yield 

    foo asdf bar fdsa

This project will eventually be extended to allow for randomly ordering the sections of the letter. 

Don't use this for spam.  Seriously -- not cool.

Code as hosted on Github is released under the MIT license.  You know where to find it. 
