class Game
  attr_reader :computer_choice, :round_result

  def initialize
    @computer_choice = nil
    @round_result = nil
  end

  def self.process_turn(player_choice, computer_choice)
    if player_choice == computer_choice
      @round_result = 2
    elsif player_choice == "Rock" && computer_choice == "Paper"
      @round_result = 0
    elsif player_choice == "Rock" && computer_choice == "Scissors"
      @round_result = 1
    elsif player_choice == "Scissors" && computer_choice == "Rock"
      @round_result = 0
    elsif player_choice == "Scissors" && computer_choice == "Paper"
      @round_result = 1
    elsif player_choice == "Paper" && computer_choice == "Rock"
      @round_result = 1
    elsif player_choice == "Paper" && computer_choice == "Scissors"
      @round_result = 0
    end
    @round_result
  end
end
