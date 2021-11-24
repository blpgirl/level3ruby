class Hi
  def initialize
  end

  def say_hi
    puts "enter your name:"
    name = gets.chomp #without chomp it saves the enter of the keyboard when i submit my name
    print "Hi " + name
  end #say_hi
end #class Hi

friendly = Hi.new
friendly.say_hi
gets()
