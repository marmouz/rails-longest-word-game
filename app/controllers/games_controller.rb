require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    array = ('A'..'Z').to_a
    @letters = []
    10.times { @letters << array[rand(array.size)] }
  end

  def score
    @word = params[:word]
    @letter_post = params[:letters]
    @english = english?
    @include = word_to_grid?(@word, @letter_post)
  end

  def english?
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    json = JSON.parse(open(url).read)
    json["found"]
  end

  def word_to_grid?(word, grid)
    word.upcase.chars.all? do |letter|
      word.upcase.count(letter) <= grid.split('').count(letter)
    end
  end
end
