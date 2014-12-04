# **** Snippet 1:  **** 
class OrangeTree
  attr_reader :age, :height
  def initialize
    @age = 0
    @oranges = []
  end
# **** test.rb; 2; 2014-12-03

# **** Snippet 2: TITLE **** 
  def age!
    @oranges += Array.new(rand(1..10)) { Orange.new } if @age > 5
  end
# **** test.rb; 11; 2014-12-03

# **** Snippet 3: test **** 
  def any_oranges?
    !@oranges.empty?
  end
# **** test.rb; 17; 2014-12-03

# **** Snippet 1: Title **** 
def method
  "code"
end
# **** test2.rb; 1; 2014-12-03

