require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word]
    array_letters = params[:letters].split(" ")
    if english_word(@word)["found"] == false
      @message = "Sorry but #{@word} does not seem to be a valid English word."
    elsif @word.upcase.split("").all? { |letter| array_letters.include?(letter) } == false
      @message = "Sorry but #{@word} cannot be built out of the grid"
    else
      @message = "Congratulations! #{@word} is a valid English word"
    end
  end

  def english_word(attempt)
    url = 'https://wagon-dictionary.herokuapp.com/' + attempt
    wagon_dico = open(url).read
    return JSON.parse(wagon_dico) # it is a hash
  end
end
