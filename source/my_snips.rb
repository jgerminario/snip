# **** Snippet 1 **** 
class OrangeTree
  attr_reader :age, :height
  def initialize
    @age = 0
    @height = 0
    @oranges = []
  end

# **** Snippet 2 **** 
  def age!
    p @age += 1
    @height +=3
    @oranges += Array.new(rand(1..10)) { Orange.new } if @age > 5
  end

# **** Snippet 3 **** 
  def any_oranges?
    !@oranges.empty?
  end

  def pick_an_orange!
    raise NoOrangesError, "This tree has no oranges" unless self.any_oranges?
    @oranges.pop
  end

