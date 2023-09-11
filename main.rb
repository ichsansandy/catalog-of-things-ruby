puts "Welcome to Catalog of Things! \n\n"

def menu
  puts 'Choose an option:'
  puts '1. List all books'
  puts '2. List all music albums'
  puts '3. List of games'
  puts '4. List all genres (e.g \'Comedy\', \'Thriller\')'
  puts '5. List all labels (e.g \'Gift\', \'New\')'
  puts '6. List all authors (e.g \'Stephen King\', \'JK Rowling\')'
  puts '7. Add a books'
  puts '8. Add a music albums'
  puts '9. Add a games'
  puts '10. Exit'
end

loop do
  menu
  option = gets.chomp

  case option
  when '1'
    puts '1'
  when '2'
    puts '2'
  when '3'
    puts '3'
  when '4'
    puts '4'
  when '5'
    puts '5'
  when '6'
    puts '6'
  when '7'
    puts '7'
  when '8'
    puts '8'
  when '9'
    puts '9'
  when '10'
    print 'Thank you for using this app!'
    break
  end

  puts "\n"
end
