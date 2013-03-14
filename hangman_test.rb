require "simplecov"
SimpleCov.start

require "test/unit"
require_relative "hangman"

class TestHangman < Test::Unit::TestCase

	def test_get_random_word_should_return_word_correctly_formatted
		$wordarray = ["Locomotive"]
		player = Hangman.new
		assert_equal "l o c o m o t i v e ", player.get_random_word
	end

	def test_status_should_show_correct_underscores_1
		player = Hangman.new
		player.word = "p r i n t e r "
		player.userinput = ["i", "t"]
		assert_equal "_ _ i _ t _ _ ", player.status
	end

	def test_status_should_show_correct_underscores_2
		player = Hangman.new
		player.word = "p r i n t e r "
		player.userinput = ["x", "t", "y", "p"]
		assert_equal "p _ _ _ t _ _ ", player.status
	end

	def test_success_should_return_true_if_match
		player = Hangman.new
		player.word = "test"
		player.userinput = ["p", "t", "s", "e", "t"]
		assert_equal true, player.success?
	end

	def test_success_should_return_false_if_no_match
		player = Hangman.new
		player.word = "test"
		player.userinput = ["p", "t", "e", "r", "e", "y"]
		assert_equal false, player.success?
	end

	def test_chances_should_make_correct_deduction	
		player = Hangman.new
		assert_equal 8, player.chances
	end

	def test_count_guesses_start_at_0	
		player = Hangman.new
		assert_equal 0, player.count_guesses
	end

	def test_guesses_should_return_userinput_array
		player = Hangman.new
		player.userinput = ["one", "two"]
		assert_equal ["one", "two"], player.guesses
	end
	
end