# **** Snippet 1 **** 
class OrangeTree
  attr_reader :age, :height
  def initialize
    @age = 0
    @oranges = []
  end

# **** Snippet 2 **** 
  def age!
    @oranges += Array.new(rand(1..10)) { Orange.new } if @age > 5
  end

# **** Snippet 3 **** 
  def any_oranges?
    !@oranges.empty?
  end

