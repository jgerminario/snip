# <*snip*> Title of first snip
  desc "create the database"
  task :create do
    puts "Creating file #{DB_PATH} if it doesn't exist..."
    touch DB_PATH
  end
# </*snip*>

# <*snip*> Title of this snip
  desc "drop the database"
  task :drop do
    puts "Deleting #{DB_PATH}..."
    rm_f DB_PATH
  end
# </*snip*>

# <*snip*> Title of first snip
  desc "create the database"
  task :create do
    puts "Creating file #{DB_PATH} if it doesn't exist..."
    touch DB_PATH
  end
# </*snip*>

# <*snip*> Title of this snip
  desc "drop the database"
  task :drop do
    puts "Deleting #{DB_PATH}..."
    rm_f DB_PATH
  end
# </*snip*>