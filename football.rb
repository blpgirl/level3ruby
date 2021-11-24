require_relative "logger.rb"
include Logger

class FootballTeam
  attr_accessor :name, :score #attr_accessor is used to make a variable both readable and writeable,
                              #it is a shortcut to attr_reader and attr_writer

  WIN_SCORE = 3
  TIE_SCORE = 1
  LOOSE_SCORE = 0

  def initialize(name)
    @name    = name
    @score = 0
  end #initialize

=begin
  Method to update score for the team
  result can be :tie for tie, :win for winning, :lose for loosing
=end
  def update_score(result)
    score_to_add = case result
      when :tie then TIE_SCORE
      when :win then WIN_SCORE
      when :lose then LOOSE_SCORE
      else 0
    end #case

    @score = @score + score_to_add
    log("A score has been updated", level: :WARN)
  end #update_score
end #class FootballTeam

class Tournament
  attr_accessor :teams

  def initialize
    @teams = [] # A fresh clean array for storing teams
  end #initialize

  #add a new team to the Tournament
  def register_a_team(name:) #to make it easier to read i can pass it as name: <name_variable_parameter>, not with symbols
    # The << means add to the end of the array
    @teams << FootballTeam.new(name)
    log("a new team has been registered to the tournament. Welcome #{name}!")
  end #register_a_team

  def set_results(results)
    results.each { |key, result|
      if result["goals1"] > result["goals2"]
        winning_team = @teams.find { |team| team.name == result["team1"] } #similar to select but only one element
        winning_team.update_score(:win)
        loosing_team = @teams.find { |team| team.name == result["team2"] }
        loosing_team.update_score(:lose)
      elsif result["goals1"] < result["goals2"]
        winning_team = @teams.find { |team| team.name == result["team2"] } #similar to select but only one element
        winning_team.update_score(:win)
        loosing_team = @teams.find { |team| team.name == result["team1"] }
        loosing_team.update_score(:lose)
      else
        #it was a tie
        (@teams.find { |team| team.name == result["team1"] }).update_score(:tie)
        (@teams.find { |team| team.name == result["team2"] }).update_score(:tie)
      end
    }
  end #set_results

  def display_tournament_standings
    #order by score min to maximum, then reverse it for maximum score first
    @teams.sort_by!{|team| team.score}.reverse! #same as @teams.sort_by!(&:score).reverse!
    #print @teams

    puts "Team name  | Score"
    #display table
    @teams.each { |team|
      puts "#{team.name.ljust(10)} | #{team.score.to_s.center(6)}" #ljust to justify left,
                                                      #center to center score text as 6 characters
    }

  end #display_tournament_standings

end #class Tournament

my_tournament = Tournament.new
#add the teams
teams =  ["Team A", "Team B", "Team C", "Team D"]
teams.each {|team| my_tournament.register_a_team(name: team)} #to make it easier to read, had to defined parameter as name:

#set the matches results
results = {1=>{"team1"=>"Team A", "goals1"=>3, "team2"=>"Team B", "goals2"=>1},
2=>{"team1"=>"Team C", "goals1"=>0, "team2"=>"Team D", "goals2"=>0},
3=>{"team1"=>"Team A", "goals1"=>1, "team2"=>"Team C", "goals2"=>1},
4=>{"team1"=>"Team B", "goals1"=>2, "team2"=>"Team D", "goals2"=>3},
5=>{"team1"=>"Team A", "goals1"=>2, "team2"=>"Team D", "goals2"=>1},
6=>{"team1"=>"Team B", "goals1"=>3, "team2"=>"Team C", "goals2"=>1}}
my_tournament.set_results(results)

#show the table score
print "\n"
my_tournament.display_tournament_standings

log("no message show", level: :DONTEXIST)
