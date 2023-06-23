# frozen_string_literal: true

require_relative 'generate_answer_key'

#
# Generate a key with location of the correct answer based length of the category text
#
class CategoryTextKeyGenerator
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
		location = question[:category].length % 10
		answer_key = GenerateAnswerKey.get_random_key(location) +
                     correct_answer +
                     GenerateAnswerKey.get_random_key(9 - location)
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
		location = question[:category].length % 10
		question[:answer_key][location].to_i
	end
end
