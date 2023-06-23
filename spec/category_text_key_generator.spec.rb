# frozen_string_literal: true

require_relative '../lib/category_text_key_generator'

RSpec.describe CategoryTextKeyGenerator do
	describe 'key generation' do
		it 'validate 100 iterations of key generation' do
			100.times do |i|
				num_of_words = rand(3..8)
				category = GenerateAnswerKey.get_random_phrase num_of_words
				correct_answer = i % 4

				question = {
					id: i,
					category: category,
					type: 'multiple',
					difficulty: 'medium',
					question: 'What was the first living creature in space?', answer_key: correct_answer,
					answers: ['Fruit Flies', 'Mouse', 'Dog', 'Monkey']
				}

				CategoryTextKeyGenerator.update_answer_key(question)
				answer_key = question[:answer_key]

				location = question[:category].length % 10
				answer = answer_key[location..location].to_i
				expect(answer).to eq(correct_answer)
			end
		end
	end

	describe 'validate decryption' do
		it 'validate 100 iterations of key decryption' do
			100.times do |i|
				num_of_words = rand(3..8)
				category = GenerateAnswerKey.get_random_phrase num_of_words
				correct_answer = i % 4

				question = {
					id: i,
					category: category,
					type: 'multiple',
					difficulty: 'medium',
					question: 'What was the first living creature in space?', answer_key: correct_answer,
					answers: ['Fruit Flies', 'Mouse', 'Dog', 'Monkey']
				}

				CategoryTextKeyGenerator.update_answer_key(question)
				answer = CategoryTextKeyGenerator.decrypt_answer_key(question)
				expect(answer).to eq(correct_answer)
			end
		end
	end
end
