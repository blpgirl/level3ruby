=begin
   I can add at the beginning of the file the comment
   # frozen_string_literal: true
   this is a magic comment, will turn all the strings in this file to immutable (frozen)
=end

first_coffee = "espresso"
second_coffee = first_coffee

second_coffee[0] = "E"

puts second_coffee

puts first_coffee #just change both variables... could cause bugs and troubles

second_coffee = first_coffee.clone #this allows me to modify second_coffe without modifying first_coffee

first_coffee = ["americano"].freeze #can´t freeze strings directly that´s why an array, need the magic comment
#first_coffee[0] = "Espresso" #will throw an error

a = [ "a", "b", "c" ]
a.freeze #Prevents further modifications to a. A RuntimeError will be raised if modification is attempted.
         #There is no way to unfreeze a frozen object.

#a << "z" #throws an exception can't modify frozen Array

class Foo
  def mutate_self
    @x = 5
  end
end

f = Foo.new
f.freeze #can freeze almost any object. The only exception is classes that inherit from BasicObject

module Friends
  NAMES = ['Tom', 'Dane']
end

# mutation is allowed
Friends::NAMES << 'Alexander'
p Friends::NAMES #=> ["Tom", "Dane", "Alexander"]

# reassignment triggers a warning
Friends::NAMES = ['some', 'other', 'people']
#=> warning: already initialized constant Family::NAMES

module Family
  NAMES = ['Tom', 'Dane'].freeze #no one can modify or overwrite my array
end

Family::NAMES.first.upcase!
p Family::NAMES #=> ["TOM", "Dane"] #unfortunately they still can modify the elements of my array

x = 5 #symbols and numbers are automatically frozen in Ruby

#there is a gem for recursive freeze. So gems are like libraries?
# https://github.com/dkubb/ice_nine

f.mutate_self #=> RuntimeError: can't modify frozen Foo
