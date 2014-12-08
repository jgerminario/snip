# **** Snippet 0: Title of first snip **** 
# Snipped from rspec/test_snip_files//subfolder/test3.rb:1 on 12-07-2014
  desc "create the database"
  task :create do
    puts "Creating file #{DB_PATH} if it doesn't exist..."
    touch DB_PATH
  end


# **** Snippet 1: Title of this snip **** 
# Snipped from rspec/test_snip_files//subfolder/test3.rb:9 on 12-07-2014
  desc "drop the database"
  task :drop do
    puts "Deleting #{DB_PATH}..."
    rm_f DB_PATH
  end


# **** Snippet 2: Title of first snip **** 
# Snipped from rspec/test_snip_files//subfolder/test3.rb:17 on 12-07-2014
  desc "create the database"
  task :create do
    puts "Creating file #{DB_PATH} if it doesn't exist..."
    touch DB_PATH
  end


# **** Snippet 3: Title of this snip **** 
# Snipped from rspec/test_snip_files//subfolder/test3.rb:25 on 12-07-2014
  desc "drop the database"
  task :drop do
    puts "Deleting #{DB_PATH}..."
    rm_f DB_PATH
  end


# **** Snippet 0: Title of this snip **** 
# Snipped from rspec/test_snip_files//test.rb:1 on 12-07-2014
class OrangeTree
  attr_reader :age, :height
  def initialize
    @age = 0
    @oranges = []
  end


# **** Snippet 1: TITLE **** 
# Snipped from rspec/test_snip_files//test.rb:10 on 12-07-2014
  def age!
    @oranges += Array.new(rand(1..10)) { Orange.new } if @age > 5
  end


# **** Snippet 2: test **** 
# Snipped from rspec/test_snip_files//test.rb:16 on 12-07-2014
  def any_oranges?
    !@oranges.empty?
  end


# **** Snippet 0: Title ggg **** 
# Snipped from rspec/test_snip_files//test2.rb:1 on 12-07-2014
def method
  "code"
end


# **** Snippet 1: Title 2323 **** 
# Snipped from rspec/test_snip_files//test2.rb:7 on 12-07-2014
def method
  "code"
end


# **** Snippet 2: Title 4 **** 
# Snipped from rspec/test_snip_files//test2.rb:13 on 12-07-2014
def method
  "code"
end


