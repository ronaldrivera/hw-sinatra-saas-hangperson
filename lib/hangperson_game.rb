class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  attr_accessor :word, :guesses, :wrong_guesses
  
  def guess l
    raise ArgumentError, 'Empty | Nil | Not a letter' unless l =~ /^[a-zA-Z]/
    l.downcase!
    if word.include? l and not guesses.include? l
      guesses << l
    elsif not word.include? l and not wrong_guesses.include? l
      wrong_guesses << l
    else
      false
    end
  end
  
  def word_with_guesses
    w = word
    w.split('').each do |l|
      if not guesses.include? l
        w[word.index l] = '-'
      end
    end
    w
  end
  
  def check_win_or_lose
    return :win if not word_with_guesses.include? '-'
    return :lose if wrong_guesses.length >= 7
    :play
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
