# frozen_string_literal: true

require 'net/http'
require 'json'

require_relative 'leading_digits_key_generator'

#
# Retrieve questions from {OpenTrivia DB}[https://opentdb.com/] with an encrypted
# answer key
#
class OpenTriviaDB
	# @return [class] Generator that implements the GenerateAnswerKey interface
	attr_accessor :generator

	# @return [string] url of the service; defaults to {https://opentdb.com/api.php}[https://opentdb.com/api.php]
	attr_accessor :url

	#
	#
	#
	def initialize
		@url = 'https://opentdb.com/api.php'
	end

	#
	# Retrieve questions from OpenTrivia DB. See
	# {Trivia API}[https://opentdb.com/api_config.php] for definition of parameters.
	#
	# @option params [hash] :params query parameters
	#
	# @return [hash] question list
	#
	def get(params = {})
		# Ensure amount parameter passed
		params = params.merge({ amount: 10 }, params)

		uri = URI(@url)
		uri.query = URI.encode_www_form(params)
		res = Net::HTTP.get_response(uri)

		out = {
			response_code: 0,
			response_message: 'OK',
			params: params,
			questions: {}
		}

		# rubocop:disable Style/ConditionalAssignment
		case res.code.to_i
		when 200
			json = JSON.parse(res.body)
			case json['response_code']
			when 0
				# Valid query
				out = out.merge({
					questions: process_questions(json['results'])
				})
			else
				# Invalid, possibly parameters related
				out = out.merge({
					response_code: json['response_code'],
					response_message: 'invalid query'
				})
			end
		else
			# Server error (ie 404, 503)
			out = out.merge({
				response_code: res.code.to_i,
				response_message: res.message
			})
		end
		# rubocop:enable Style/ConditionalAssignment
		out
	end

	private

	#
	# Reformat questions and randomize answers
	#
	# @param [Array] list questions from the api
	#
	# @return [Array] reformated questions
	#
	def process_questions(list)
		questions = []
		list.each_with_index do |q, i|
			question = {}
			question[:id] = i + 1
			question[:category] = q['category']
			question[:difficulty] = q['difficulty']
			question[:type] = q['type']
			question[:question] = q['question']
			question[:answer_key], question[:answers] = randomize_answers(q['correct_answer'], q['incorrect_answers'])

			@generator&.update_answer_key(question)

			questions.append(question)
		end
		questions
	end

	#
	# Randomize the order of the correct and incorrect answers.
	#
	# @param [string] correct correct answer
	# @param [array] incorrect incorrect answers
	#
	# @return [array] zero-based index of the correct answer and array of all answers
	#
	def randomize_answers(correct, incorrect)
		answers = incorrect.append(correct).shuffle
		location = answers.find_index(correct)
		[location, answers]
	end
end
