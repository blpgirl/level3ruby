data = { :name => "Leyla Bonilla", :age => 32, :position => "Full Stack Software Engineer"}

File.open("data.txt", "w") do |file| #w is to be able to write
  data.each{ |key, value|
    file.write("#{key}: #{value} \n") #write my array to the file
  }
end

File.open("data.txt")  do |file|
  puts file.read #prints what is on the file
end
