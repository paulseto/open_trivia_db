# frozen_string_literal: true

require_relative '../lib/leading_digits_key_generator'

RSpec.describe LeadingDigitsKeyGenerator do
	describe 'key generation' do
		it 'validate 100 iterations of key generation for multiple choice question' do
			100.times do |i|
				correct_answer = i % 4
				question = {
					id: i,
					category: 'Science & Nature',
					type: 'multiple',
					difficulty: 'medium',
					question: 'What was the first living creature in space?', answer_key: correct_answer,
					answers: ['Fruit Flies', 'Mouse', 'Dog', 'Monkey']
				}
				LeadingDigitsKeyGenerator.update_answer_key(question)
				answer_key = question[:answer_key]
				location = answer_key[0..1].to_i % 8
				answer = answer_key[location + 2].to_i
				expect(answer).to eq(correct_answer)
			end
		end
		it 'validate 100 iterations of key generation for true/false question' do
			100.times do |i|
				correct_answer = i % 2
				question = {
					id: i,
					category: 'Science',
					type: 'boolean',
					difficulty: 'medium',
					question: 'There is no such thing as "Science"',
					answer_key: correct_answer,
					answers: %w[True False]
				}
				LeadingDigitsKeyGenerator.update_answer_key(question)
				answer_key = question[:answer_key]
				location = answer_key[0..1].to_i % 8
				answer = answer_key[location + 2].to_i
				expect(answer).to eq(correct_answer)
			end
		end
	end

	describe 'decrypting answer_key' do
		it 'validate decryption' do
			100.times do |i|
				correct_answer = i % 4
				question = {
					id: i,
					category: 'Science & Nature',
					type: 'multiple',
					difficulty: 'medium',
					question: 'What was the first living creature in space?', answer_key: correct_answer,
					answers: ['Fruit Flies', 'Mouse', 'Dog', 'Monkey']
				}
				LeadingDigitsKeyGenerator.update_answer_key(question)

				answer_index = LeadingDigitsKeyGenerator.decrypt_answer_key(question)
				expect(correct_answer).to eq(answer_index)
			end
		end
	end

end
