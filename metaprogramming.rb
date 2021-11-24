class Developer #Developer is an instance of Class

  def self.backend #class method. Sames as Developer.backend
    #Inside class methods, self refers to the class itself
    p "inside class method, self is: " + self.to_s
  end

  def frontend #instance method
    #regular method that is available on instances of class Developer
    p "inside instance method, self is: " + self.to_s
  end

  define_method :weird_frontend do |*my_arg| #same as def weird_frontend(*my_arg)
    my_arg.inject(1, :*) #to handle arrays, I'm multiplying all the elements in my_arg (all parameters)
  end

  def method_missing method, *args, &block
    return super method, *args, &block unless method.to_s =~ /^coding_\w+/ #only when the method name starts with "coding_"
    self.class.send(:define_method, method) do #define a new method
      p "writing " + method.to_s.gsub(/^coding_/, '').to_s
    end
    self.send method, *args, &block
  end

end

p Developer.class # Class
developer = Developer.new
developer.frontend
# "inside instance method, self is: #<Developer:0x2ced3b8>"
p developer.weird_frontend(2, 5, 20)

Developer.backend
# "inside class method, self is: Developer"

developer.coding_frontend
developer.coding_backend #new method created because it starts with coding
developer.coding_debug
developer.dont_exist #throws an exception that is an undefined method since doesn't start with coding
