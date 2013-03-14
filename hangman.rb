require './wordarray_file'

class Hangman

	class InputError < StandardError
	end

	attr_accessor :word, :userinput

	def initialize
		@userinput = Array.new
		@@count_guesses = 0
	end

	def total_guesses
		8
	end

	def count_guesses
		@@count_guesses 
	end

	def get_random_word
		@word = $wordarray.sample.downcase.gsub(/(.{1})/, '\1 ') # RegEx makes spaces after each letter
	end

	def initial_screen_message
		number_of_characters = word.gsub(/\s+/, "").length # RegEx takes spaces out
		puts
		puts "The word you are looking for is #{number_of_characters} characters long."
		puts
		number_of_characters.times do
			print "_ "
		end  
		puts
		puts
		puts "Chances: #{total_guesses}"
		puts
		puts "Guesses: _"
		puts
  	end

	def input
		newinput = gets.chomp.downcase.strip
		# Input checks
		if newinput.length > 1
			raise InputError.new("#{newinput} is longer than 1 character. Please input only one character!")
		end
		# Count_guesses update
		unless word.include?(newinput) || userinput.include?(newinput)
			@@count_guesses += 1
		end
		# add user input to array
		userinput << newinput
	end

	def status
		displayed_word = word.gsub /[^"#{userinput}", " "]/, '_'
		displayed_word
	end	

	def success?
		if status == word 
			true
		else
			false
		end
	end

	def chances		
		total_guesses - count_guesses
	end

	def guesses
		userinput
	end
 end 

 
 class Runner
 	def self.play
 		self.welcome
 		self.start
 		self.game_loop
 	end

 	def self.welcome
 		puts
 		puts "====================================================="
 		puts
 		puts "Welcome to this awesome and fun Hangman game!! Enjoy!"
		puts
		puts "====================================================="
		puts 
		puts "Tell me your name, will you?"
		puts
		name = gets.chomp
		puts
		puts "Hi #{name}!! Prove that you are awesome by playing this amazing Hangman game!"
 		puts
 		puts "====================================================="
 		puts
 		puts "\e[H\e[2J" #clears screen 
 	end

 	def self.start
 		@@player = Hangman.new
		@@player.get_random_word
		@@player.initial_screen_message
 	end

 	def self.game_loop
 		while @@player.count_guesses < @@player.total_guesses
			puts
			puts "Please input a letter of the alphabet (but choose wisely...)!"
			
			begin 
				@@player.input 
			rescue Hangman::InputError => e 
				puts e.message
				Runner.game_loop #starts new loop
			end
			
			puts "\e[H\e[2J" #clears screen 
			puts
			puts @@player.status
			puts
			puts "Chances left: #{@@player.chances}"
			puts
			puts "Guesses: #{@@player.guesses.join(" ")}"
			puts 
			puts "====================================================="
			if @@player.success? 
				break
			end
		end

		if @@player.success?
			puts "\e[H\e[2J" #clear screen 
			puts "====================================================="
			puts "====================================================="
			puts
			puts "Yeah Man!! You got it right! Try a new game..."
			puts 
			puts "====================================================="
			puts "====================================================="
		else
			puts "\e[H\e[2J" #clear screen 
			puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
			puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
			puts
			puts "You failed!!! Try again! The correct word was #{@@player.word}."
			puts
			puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
			puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
			puts
		end
 	end
 	
 end
