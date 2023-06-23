# frozen_string_literal: true

#
# Interface for generating a custom answer key
#
module GenerateAnswerKey

	#
	# Encrypt answer key
	#
	# @param [hash] question
	#
	def self.update_answer_key(question)
		raise NoMethodError("generate method not implemented")
	end

	#
	# Decrypt answer key.
	#
	# @param [hash] question
	#
	# @return [int] index of the correct answer
	#
	def self.decrypt_answer_key(question)
		raise NoMethodError("decrypt method not implemented")
	end
	#
	# Generate a random key of length 10 numbers
	#
	# @return [string] random key
	#
	def self.get_random_key(n = 10)
		return '' if n.zero?
		min = 10**n
		max = 10**(n+1)-1
		rand(min..max).to_s[0..n-1]
	end

	#
	# Generate a random word
	#
	# @param [int] n specify length of word
	#
	# @return [string] generated word
	#
	def self.get_random_word(n = 7)
		letters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
		word = ''
		n.times do
			word += letters[rand(52)]
		end
		word
	end

	#
	# Generate a random phrase
	#
	# @param [integer] n number of words
	#
	# @return [string] phrase
	#
	def self.get_random_phrase(n = 4)
		phrase = ''
		n.times do
			phrase += (phrase.length == 0 ? '': ' ') + self.get_random_word(rand(7)+3)
		end
		phrase
	end
end