require "sinatra"
require 'pry'
require_relative 'models/game.rb'

set :bind, '0.0.0.0'  # bind to all interfaces

use Rack::Session::Cookie, {
  secret: "keep_it_secret_keep_it_safe"
}

get '/index' do
  if session[:visit_count].nil?
    session[:visit_count] = 1
    session[:player_score] = 0
    session[:computer_score] = 0
    session[:winner] = false
  else
    session[:visit_count] += 1
  end

  if session[:player_score] >= 2
    session[:message] = "You chose #{session[:player_choice]} and the Computer chose #{session[:computer_choice]}. You won the GAME!"
    session[:winner] = true
  elsif session[:computer_score] >= 2
    session[:message] = "You chose #{session[:player_choice]} and the Computer chose #{session[:computer_choice]}. The Computer won the GAME!"
    session[:winner] = true
  end
  erb :index
end

post "/choose" do
  @computer_choice = ["Rock", "Paper", "Scissors"].sample
  session[:result] = Game.process_turn(params[:choice], @computer_choice)
  session[:computer_choice] = @computer_choice
  session[:player_choice] = params[:choice]

  if session[:result] == 0
    session[:message] = "You chose #{params[:choice]}. Computer chose #{@computer_choice}. Computer wins the round."
    session[:computer_score] += 1
  elsif session[:result] == 1
    session[:message] = "You chose #{params[:choice]}. Computer chose #{@computer_choice}. You win the round."
    session[:player_score] += 1
  else
    session[:message] = "You chose #{params[:choice]}. Computer chose #{@computer_choice}. Round tied."
  end
  redirect '/index'
end

post '/reset' do
  session.clear
  redirect '/index'
end
