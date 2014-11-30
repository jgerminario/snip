
#<snip>
class OrangeTree
  attr_reader :age, :height
  def initialize
    @age = 0
    @height = 0
    @oranges = []
  end
#</snip>

#<snip>
  def age!
    p @age += 1
    @height +=3
    @oranges += Array.new(rand(1..10)) { Orange.new } if @age > 5
  end
#</snip>

#<snip>
  def any_oranges?
    !@oranges.empty?
  end

  def pick_an_orange!
    raise NoOrangesError, "This tree has no oranges" unless self.any_oranges?
    @oranges.pop
  end
#</snip>

  def dead?
    @age >= 50
  end
end
