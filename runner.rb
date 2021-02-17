require_relative 'config/environment'

# Cli.new.start_game
$prompt = TTY::Prompt.new

def welcome
    puts "Welcome to:"
    title = Artii::Base.new(:font => "slant")
    puts title.asciify("Potions and Lotions")
end


# binding.pry
