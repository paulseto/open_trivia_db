# frozen_string_literal: true

require_relative '../lib/open_trivia_db'

RSpec.describe OpenTriviaDB do
	describe 'validate amount parameter' do
		it 'respond with 10 questions' do
			params = { amount: 10 }
			json = OpenTriviaDB.new.get(params)
			expect(json[:response_code]).to eq(0)
			expect(json[:response_message]).to eq('OK')
			expect(json[:questions].length).to eq(10)
		end

		it 'respond with 10 questions when amount not specified' do
			params = {}
			json = OpenTriviaDB.new.get(params)
			expect(json[:response_code]).to eq(0)
			expect(json[:response_message]).to eq('OK')
			expect(json[:questions].length).to eq(10)
		end

		it 'results from an negative amount' do
			response = OpenTriviaDB.new.get({ amount: -2 })
			expect(response[:response_code]).to eq(2)
		end

		it 'results from large amount (1000) only returns 50' do
			response = OpenTriviaDB.new.get({ amount: 1000 })
			expect(response[:response_code]).to eq(0)
			expect(response[:response_message]).to eq('OK')
			expect(response[:questions].length).to eq(50)
		end
	end
end
