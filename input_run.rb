class Hi
  def initialize
  end

  def say_hi
    name = ARGV[0] #run it as ruby input_run.rb "My name"
                  #params send to the app are save in this ARGV array
                  #Ruby captures command line arguments with a special array named ARGV
                  #if i do ruby testing_argv.rb these are elements in the argv array
                  #then ARGV will be ["these", "are", "elements", "in", "the", "argv", "array"]
    print "Hi " + name + "\n"
  end #say_hi
end #class Hi

friendly = Hi.new
friendly.say_hi

print [1,2,3]<<"add to last"
print "\n"

numbers = [1,2,3,4,5,6]
impares = numbers.delete_if{|n| n%2==0} #removes numbers divisibles por 2
for i in impares
  puts i
end

numbers = [1,2,3,4,5,6]
impares = numbers.delete_if{|n| n.even?} #same as up, removes even numbers (divisibles por 2)
for i in impares
  puts i
end

puts "starts lambda"
lamb = lambda {|numero| numero + 1} #a lambda is a method without name
puts lamb.call(3)

say_something = -> { puts "This is a lambda" }
say_something.call

lamb = lambda do |name| #if more than 1 line of code then is better to put do and end instead of {}
  if(name=="Pedro")
    return "Hi Pedro, good to see you again"
  else
    return "Hi #{name}, who are you?"
  end #else
end #lambda
puts lamb.call("Manuel")
