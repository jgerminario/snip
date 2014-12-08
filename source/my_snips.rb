
# **** Snippet 41:  ****
# Snipped from lib/snips_to_process/test.rb:2 on 12-07-2014
class OrangeTree
  attr_reader :age, :height
  def initialize
    @age = 0
    @oranges = []
  end


# **** Snippet 42: TITLE ****
# Snipped from lib/snips_to_process/test.rb:11 on 12-07-2014
  def age!
    @oranges += Array.new(rand(1..10)) { Orange.new } if @age > 5
  end


# **** Snippet 43: test ****
# Snipped from lib/snips_to_process/test.rb:17 on 12-07-2014
  def any_oranges?
    !@oranges.empty?
  end


# **** Snippet 44: Title ****
# Snipped from lib/snips_to_process/test2.rb:1 on 12-07-2014
def method
  "code"
end


