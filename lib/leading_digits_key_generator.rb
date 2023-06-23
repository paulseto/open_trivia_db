# frozen_string_literal: true

require_relative 'generate_answer_key'

#
# Generate a key with location of the correct answer based on the first two digits
#
class LeadingDigitsKeyGenerator
	include GenerateAnswerKey

	#
	# Encrypt answer_key
	#
	# @param [hash] question question information
	#
	# @return [hash] answer key
	#
	def self.update_answer_key(question)
		correct_answer = question[:answer_key].to_s
		key = GenerateAnswerKey.get_random_key
		location = key[0..1].to_i % 8
		answer_key = key[0..(location + 1)] + correct_answer + key[location + 3..9]
		question[:answer_key] = answer_key
	end

	#
	# Decrypt answer key
	#
	# @param [hash] question
	#
	# @return [integer] index of the correct answer from the answer array
	#
	def self.decrypt_answer_key(question)
		location = question[:answer_key].to_s[0..1].to_i % 8
		question[:answer_key][location + 2].to_i
	end
end
