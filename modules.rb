module Cream #to reuse methods in multiple classes
  def cream?
    true
  end
end

class Cookie
  include Cream #include the module with methods, class and constants to reuse
end

cookie = Cookie.new
p cookie.cream? #p is similar to print, it can execute cream method because Cookie includes the module

module Sugar #to reuse methods in multiple classes
  def add_sugar
    p "Too much sugar"
  end
end

class Chocolate
  include Cream #include the module with methods, class and constants to reuse
  extend Sugar
end

Chocolate.add_sugar #don't need to create an object to use the extended module
#Chocolate.new.add_sugar throws an exception because is extended not included
chocolate = Chocolate.new
chocolate.extend(Sugar).add_sugar


require 'digest'

module Encryption
  def encrypt(string)
    Digest::SHA2.hexdigest(string)
  end
end

class Person
  include Encryption

  def initialize (name)
    @name = name
  end

  #get method
  def password
      @password
  end

  #set method
  def password=( value )
    @password = value
  end

  def give_me_encrypted_password
      encrypted_password
  end #encrypted_password

  private def encrypted_password #If I set it to private it means only the object itself is supposed to use them
                                #internally, from other methods. So only the Person class can access it from inside
    encrypt(@password) #use the method in the Encryption module
  end #encrypted_password
end

person = Person.new("Ada")
person.password = "super secret"
puts person.give_me_encrypted_password #will throw an exception
#puts person.encrypted_password #will throw an exception because that method is private

[1, 2, 3, 4, 5].each do |number| #for blocks, do |number| is the same that is def add_two (number) for a method definition
  puts "#{number} was passed to the block" #the block is what goes between do and end
end

#The method with_index can be called on any iterator object.
#All it does is pass the index of the element within the array to the block, as a second block argument
numbers = [1, 2, 3, 4, 5].collect.with_index do |number, index| #number is value of array and the index is the key
  number + index #first 1(element)+0(index), second 2+1...
end
p numbers

def print_once
  yield #this means, execute any code pass to print_once
  puts "i can also repeat the code"
  yield
end
print_once { puts "Block is being run" }

def one_two_three
  yield 1 #passing the argument 1 to the block
  yield 2
  yield 3
end
one_two_three { |number| puts number * 10 }

def explicit_block(&block)
  block.call # same as yield
end
explicit_block { puts "Explicit block called" }

def do_something_with_block
  if block_given? then yield
  else puts "No block given"
  end
end

do_something_with_block
do_something_with_block { puts "this is my block" }

class PDFReporter
  def generate(title:, month:)
    puts "generando reporte #{title}"
    if block_given?
      yield month #with yield I execute my block of code and pass the parameter month
    end #if block_given
  end #method generate
end #class PDFReporter

report = PDFReporter.new
report.generate(title: "Mensual", month: "Octubre") do |month|
  puts "Reporte de #{month}" #this is my block, I recieve month when yield calls the block
end #end of do

my_proc = Proc.new { |x| puts x } #similar to lambdas which are a special proc
my_proc.call 3
t = Proc.new { |x,y| puts "I don't care about arguments!" } #lambda will throw an exception if the arguments are not send
t.call

# Should work
my_lambda = -> { return 1 }
puts "Lambda result: #{my_lambda.call}"

# Should raise exception. Whaaaaaat? not sure how this works... i guess you can't return stuff in procs
my_proc = Proc.new { return 1 } #a proc will try to return from the current context.
#puts "Proc result: #{my_proc.call}"

def call_proc
  puts "Before proc"
  my_proc = Proc.new { return 2 }
  my_proc.call
  puts "After proc"
end
p call_proc
# Prints "Before proc" but not "After proc"

def call_proc(my_proc)
  count = 500 #doesn't use this because it uses the variables from where the proc is defined
            #the proc was defined outside this method, therefore the count is the one outside as well
  my_proc.call
end

count   = 1
my_proc = Proc.new { puts count }
p call_proc(my_proc) # prints 1 which is the first count defined and then nil why?

var = Proc.new{|num1,num2,num3| num1+num2+num3}

p "The sum is #{var[1,3,4]}"

var = Proc.new do |num| #when is more than 1 line of code
	i = 1
	while(i<=10)
		p num * i
		i = i + 1
	end
end
var[2]
var.call(2)

#Private Methods
class PersonSocial
  def speak
    puts "Hey, Tj!"
  end
  def whisper_louder
    whisper
  end
# private methods are for internal usage within the defining class
  private
  def whisper
    puts "His name's not really 'Tj'."
  end

  protected
 def self.greet
   puts "Hey, wassup!"
 end
end

you = PersonSocial.new
you.speak # "Hey, Tj!"
a_hater = PersonSocial.new
a_hater.speak # "Hey, Tj!"
#a_hater.whisper # NoMethodError
a_hater.whisper_louder # "His name's not really 'Tj'."

a_hater.send :whisper #esto es trampa para volarme los permisos de private y protected con el send

class Me
  def be_nice
    PersonSocial.greet #in protected instances can call the method, if private it throws an error
  end
end
tj = Me.new
tj.be_nice # "Hey, wassup!"
#tj.greet # NoMethodError, can't call it from the outside as private

class Animal
  def intro_animal
    class_name
  end
  private
  def class_name
    "I am a #{self.class}"
  end

  def animal_call
    protect_me
  end

  def walk n
    p "Walking to " + n
  end

  protected
  def protect_me
    p "protect_me called from #{self.class}"
  end
end

class Amphibian < Animal
  def intro_amphibian
    class_name #classes that inherits can also call private methods from inside the class
  end

  def amphi_call
    Mammal.new.protect_me #Receiver same as self, can call protected but not private methods this way
    protect_me  #Receiver is self, same as self.protect_me
  end

  def walk n, m
    super(n) #referencing the same method in parent class so it executes
    p "Tired of walking #{m} miles"
  end
end

class Mammal < Animal
  def mammal_call
    protect_me
  end
end

n= Amphibian.new
p  n.intro_amphibian #=>I am a Amphibian
n.amphi_call
n.walk "miami", 5000

class Cat < Animal
  def talk
    "Meaow!"
  end
end

class Dog < Animal
  def talk
    "Woof!"
  end
end

p Dog.new.talk #polimorfismo, objetos de diferentes clases con el mismo metodo
              #que se puede trabajar porque retorna lo mismo
p Cat.new.talk

def nombres(*arguments) #parameters as array, also optional parameters (always at the right side of the mandatory parameters)
  print arguments
end
nombres("Daniel","Miguel","Maria","Julia") #le puedo pasar todos los parametros que quiera

def method_missing(m, *args, &block)
  puts "How did you get here? why did you call #{m}?" #m is the name of the method that was called
  #*args ~ This sponges up any other remaining arguments. It’s an optional parameter.
  #&blocks ~ This includes blocks called within the method. It’s also an optional parameter.
  print args
  print "\n"

  if block_given? then block.call
  end
end
Dog.new.fly("florida") #dogs can't fly, there is no fly method so it will enter method_missing
Animal.new.fly{ puts 'I believe I can fly' }
