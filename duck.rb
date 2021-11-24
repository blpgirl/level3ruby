class TripStatic
def prepare(preparers)
	preparers.each do |preparer|
		case preparer
		when TravelAgentStatic #checking the class of the object, if Ruby was statically typed (which is not)
			preparer.book_flights
		when VacationerStatic
			preparer.pack_bags
		end
	    end
      end
end

class TravelAgentStatic
	def book_flights
		puts "Flights are booked!"
	end
end

class VacationerStatic
	def pack_bags
		puts "Bags are packed!"
	end
end

#with duck type
#embrace objects for their behaviors rather than their types
#In Ruby, there is no need for abstract classes and type checking.
#All you need to focus on are the messages to which your objects respond
class Trip

	def prepare(preparers: [])
		preparers.each do |preparer|
			preparer.prepare_trip #I don´t care about the object type just that it responds to prepare_trip
		end
	end
end

class TravelAgent
	def prepare_trip
		puts "Flights are booked!"
	end
end

class Vacationer
	def prepare_trip
		puts "Bags are packed!"
	end
end

Trip.new.prepare(preparers: [TravelAgent.new, Vacationer.new]) #ver si me funciona con preparer: o sino quitarlo solo parametros simples
#we don't care whether a preparer is an instance of TravelAgent or Vacationer. The class of preparer is not relevant — we only need to ensure that each preparer responds to the message prepare_trip.

class Duck
  def quack
    puts 'Duck quack'
  end
  def swim
    puts 'Duck swim'
  end
end
class Goose
  def quack
    puts 'Goose quack'
  end
  def swim
    puts 'Goose swim'
  end
end
class BirdActions
attr_reader :birds
def initialize
  @birds = []
  duck = Duck.new()
  goose = Goose.new()
  @birds.push(duck)
  @birds.push(goose)
end
def quack
  birds.each do | bird |
    bird.quack
  end
end
def swim
  birds.each do | bird |
    bird.swim
  end
end

end

action = BirdActions.new()
action.quack
action.swim


#Nested methods
class MetodoAnidado
	def nested_method
		puts "Hello there"
		def inside_method
			puts "You are in a nested method"
		end
		def inside_job
			puts "I´m a secret"
		end
	end
end
object = MetodoAnidado.new
object.nested_method #once I call the method, I can access the others methods inside it
	#otherwise, if I try to call them before, it throws an error
object.inside_method
#this could be useful if I have a method where I have to do stuff before to be able to do the next thing, then it´s a good idea to define the later one inside the previous step

puts 1+2 #same as 1.+(2) but with less sugar or 1.send(:+, 2)
puts "flat" + "iron" #same operator but different behaviour depending on the types of arguments. First sum, second concatanate
#Ruby has a lot of predefined syntactic sugar. Operators like <<, &, and | also behave differently when acted on different kinds of data type (Integer vs array).
#Ruby provides you in writing easier to read and more concise code.... not sure if easier to read, probably with a lot of practice... another example symbols like ! in methods
##syntactic sugar: syntax optimized for humans

class Lion
  include Comparable

  attr_reader :name, :age, :weight, :height, :bravery

  def initialize(name, age, weight, height, bravery)
    @name = name
    @age = age
    @weight = weight
    @height = height
    @bravery = bravery
  end

  def <=>(other_lion) #defining a comparison method for Lion
    self.bravery <=> other_lion.bravery
  end
end

simba = Lion.new("Simba", 10, 37, 60, 99)
scar = Lion.new("Scar", 42, 190, 128, 72)

puts simba > scar # we created our own sugar, comparing the bravery of our lions, otherwise it would throw an error since Ruby wouldn´t have any idea on how to compare Lions
puts simba == scar #with the <=> operator method I can also do this

class Dog
	def initialize(name:, breed:)
		@name = name
		@breed = breed
	end
	def bark
		puts "Woof!"
	end
end

doggy = Dog.new(name: "Firulais", breed: "German shepard")
doggy_two = Dog.new(name: "Max", breed: "French poodle")
def doggy.attack
	puts "You just got bitten"
end
puts doggy.attack #this method is a singleton method, only available to doggy
	#doggy_two can´t access it. This is mostly used for interfaces

class << doggy #singleton class
	def protect
		puts "The dog caught the intruder"
	end
end

if doggy.respond_to?(:protect) then #see if it has the method protect
	doggy.protect
else
	puts "This dog can´t protect you"
end
