# defined exception and handling it
def raise_and_rescue
  begin #this is more like try and catch in php but begin and rescue
    #this code may raise an exception
    # Exceptions raised by this code will
  # be caught by the following rescue clause

    puts 'This is Before Exception Arise!'

    # using raise to create an exception
    raise 'Exception Created!' #stops the execution of the program, can I create a type of exception?

    puts 'After Exception'

  # using Rescue method
  rescue #restarts the execution of the program after an exception was raised
  #... error handler
    puts 'Finally Saved!'

    #retry allows me to try the rescue again and again, could end in infinite loop so i guess you need a break or something

  end #begin

end #method raise_and_rescue

def raise_exception

puts 'Outside from Begin Block!'

  begin

      puts 'This is Before Exception Arise!'

         # using raise to create an exception
         raise 'Exception Created!'

      puts 'After Exception'

    ensure
        # this block always executes no matter what
        puts "This will always execute"
  end #begin
end #method

def callAndFetch(prompt)
  print prompt
  responseValue = readline.chomp #to read from keyboard
  throw :nameOfException if responseValue == "!" #throws an exception if value is !
  return responseValue #everything is fine, return value
end #end method

catch :nameOfException do
  student = callAndFetch("Student: ") #if it throws an exception it will get out of the catch and continue
  puts "I'm in the catch because of #{student}" #this will print if everything was fine
end #end catch
#callAndFetch("Student:") #if I put ! and it throws the exception, my app stops running because I didn't catch it

# calling method
raise_and_rescue

values = []
begin
  File.readlines('input.txt').each { |line| values << Float(line) }
rescue Errno::ENOENT
  p 'file not found'
rescue ArgumentError #another exception, it's not best practice to rescue all exceptions with generic Exception
  p 'file contains unparsable numbers'
else #everything is fine
  print values
end

score = 80.0
possible_score = nil
grade = score / possible_score rescue begin
  puts 'math error'
  0.0 #returns zero
end
puts grade

scores = [80.0, 85.0, 90.0, 95.0, 100.0]
possibles = [100.0, 100.0, 100.0, nil, 100.0]
grades = []
  for idx in 0..(scores.length-1)
    begin
      grades[idx] = scores[idx] / possibles[idx]
    rescue TypeError
      possibles[idx] = 100.0 #fix denominator
      retry #retry from the begin to get a grade for everyone
    end
end
print grades
print "\n"

scores = [80.0,85.0,90.0,95.0,100.0]
possibles = [80.0,110.0,200.0,nil,100.0]
grades=[]
for idx in 0..(scores.length-1)
  begin
    grades[idx] = scores[idx] / possibles[idx] #if both numbers are float, the division is float
  rescue TypeError
    grades[idx] = 'Computation Error'
    next #something happened, just ignore and continue with the next in the loop
  end
end
print grades
print "\n"

class MyError < StandardError
  attr_reader :thing
  def initialize(msg="This is my custom error", thing="apple")
    @thing = thing
    super(msg) #to call the StandardError initialize method
  end
end

begin
  raise MyError.new("my custome message on raise", "my thing")
rescue => e
  puts e.thing # "my thing", will catch the errors raised and do this code 
end

raise MyError #raise my custom exception, will show on my console my custome message

raise_exception #throws my exception
#list of common exceptions https://www.honeybadger.io/blog/understanding-the-ruby-exception-hierarchy/
