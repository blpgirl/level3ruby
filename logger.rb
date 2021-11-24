require 'date'
module Logger
  LEVELS = { :INFO => "INFO", :DEBUG => "DEBUG", :WARN => "WARN", :ERROR => "ERROR", :FATAL => "FATAL" }

  def log(message, level: :INFO)
    if LEVELS.has_key? level
      now = DateTime.now.strftime("%d/%m/%Y %H:%M")
      puts "#{now} > #{message} - " + LEVELS[level]

      File.open("log.txt", "a") do |file| #a is to be able to append to the end of the file
          file.puts("#{now} > #{message} - " + LEVELS[level] + " \n") #write my message to the file
      end #file do
    else
      raise "This level doesn't exist. Can't continue."
    end #if
  end #log method
end #module logger
