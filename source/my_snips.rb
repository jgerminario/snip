
# **** Snippet 1:  **** 
# Snipped from test.rb:2 on 12-07-2014
class OrangeTree
  attr_reader :age, :height
  def initialize
    @age = 0
    @oranges = []
  end


# **** Snippet 2: TITLE **** 
# Snipped from test.rb:11 on 12-07-2014
  def age!
    @oranges += Array.new(rand(1..10)) { Orange.new } if @age > 5
  end


# **** Snippet 3: test **** 
# Snipped from test.rb:17 on 12-07-2014
  def any_oranges?
    !@oranges.empty?
  end


