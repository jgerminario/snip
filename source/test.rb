
#<*snip*>  
class OrangeTree
  attr_reader :age, :height
  def initialize
    @age = 0
    @oranges = []
  end
#</*snip*>

#<*snip*>
  def age!
    @oranges += Array.new(rand(1..10)) { Orange.new } if @age > 5
  end
#</*snip*>

#<*snip*> rewer
  def any_oranges?
    !@oranges.empty?
  end
# erw</*snip*> rewr 

  def pick_an_orange!
    raise NoOrangesError, "This tree has no oranges" unless self.any_oranges?
    @oranges.pop
  end


  def dead?

    @age >= 50
  end
end
