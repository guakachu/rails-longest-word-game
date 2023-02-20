class GamesController < ApplicationController
  def new
    @letters = Array.new(7) { [*'A'..'Z'].sample }
  end

  def included?(guess, grid)
    guess.all? { |letter| grid.include?(letter) }
  end

  def acceptable_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/:#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def @score_and_message
    @answer = params[:answer]
    @answer_letters = @answer.upcase.split('')
    @grid = params[:letters].split(' ')
    if included?(@answer_letters, @grid)
      if acceptable_word?(@answer)
        @score = compute_score(@answer)
        @conclusion = 'well done!'
      else
        @score = 0
        @conclusion = 'this is not an english word, try again!'
      end
    else
      @score = 0
      @conclusion = 'your word is not in the grid'
    end
    [@score, @conclusion]
  end
end
