# frozen_string_literal: true

require_relative '../lib/generate_answer_key'

RSpec.describe GenerateAnswerKey do
	describe 'validate randomKey' do
		it '100 key generation test without number of digits' do
			100.times do
				key = GenerateAnswerKey.get_random_key
				expect(key.length).to eq(10)
			end
		end

		it '100 key generation test with random # of digits' do
			100.times do
				length = rand(10)
				key = GenerateAnswerKey.get_random_key length
				expect(key.length).to eq(length)
			end
		end
	end

	describe 'valid get_random_word' do
		it '100 words without a parameter' do
			100.times do
				expect(GenerateAnswerKey.get_random_word.length).to eq(7)
			end
		end
		it '100 words of random length' do
			100.times do
				n = rand(9)
				word = GenerateAnswerKey.get_random_word n
				expect(word.length).to eq(n)
			end
		end
	end

	describe 'validate word phrases' do
		it '100 phrases without a parameter' do
			100.times do
				phrase = GenerateAnswerKey.get_random_phrase
				num_of_words = phrase.split.length
				expect(num_of_words).to eq(4)
			end
		end
		it '100 phrases with a random number of words' do
			100.times do
				n = rand(1..10)
				phrase = GenerateAnswerKey.get_random_phrase n
				num_of_words = phrase.split.length
				expect(num_of_words).to eq(n)
			end
		end
	end
end
