class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end

  def initialize(word)
    @word           = word
    @guesses        = ''
    @wrong_guesses  = ''
  end
  attr_reader :word
  attr_reader :guesses
  attr_reader :wrong_guesses

  def guess(letter)
      if not letter =~ /^[a-zA-Z]$/
        raise ArgumentError, 'Argument is not a letter'
      end
      letter = letter.downcase
      if @word.include? letter
        if not @guesses.include? letter
          @guesses << letter
          return true
        else
          return false
        end
      else
        if not @wrong_guesses.include? letter
          @wrong_guesses << letter
          return true
        else
          return false
        end
      end
  end

  def guess_several_letters(letters)
    letters.each do |letter|
      guess(letter)
    end
  end

  def word_with_guesses
    wg = ''
    @word.each_char do |letter|
      if @guesses.include? letter
        wg << letter
      else
        wg << '-'
      end
    end
    return wg
  end

  def check_win_or_lose
    if @word.each_char.all? {|letter| @guesses.include? letter}
      return :win
    elsif @wrong_guesses.length >= 7
      return :lose
    else
      return :play
    end
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
