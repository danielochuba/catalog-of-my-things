require_relative 'app'

app = App.new

puts
puts 'Welcome to my Catalog of things!'
puts '********************************'
puts

loop do
  app.display_options
  option = gets.chomp.to_i
  option_value = app.process_input(option)

  break if option_value == 'exit'
end
