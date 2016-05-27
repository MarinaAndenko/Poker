require_relative 'pack'
require_relative 'combination'

class Game
  def initialize
    pack = Pack.new
    @hidden = pack.hidden
    @open = pack.open
  end

# Call the Combination method 
  def game
    print @hidden
    puts
    print @open
    puts
    preparation
    c = Combination.new(@hidden, @open)
    c.find_combination
  end

  private
  # Some actions to prepare data for the game
  def preparation
    return unless inspect_duplicates(@hidden + @open)
    @hidden = my_split(@hidden)
    @open = my_split(@open)
  end

  # Method for checking if the duplicates exist in our cards
  def inspect_duplicates(array)
    array.each do |element|
      if array.count(element) > 1
        puts "The are duplicates in the cards!"
        return false
      end
      true
    end 
  end

  # Method for splitting chars array (our cards set), which help to use cards in array as numbers - odd, colors - even elements of array 
  def my_split(array) 
    splitted = []
    array.each do |element|
      element.split(//).each { |each_splitted| splitted << each_splitted }
    end
    splitted
  end  
end

game = Game.new
game.game
