# frozen_string_literal: true

require_relative '../lib/open_trivia_db'

RSpec.describe OpenTriviaDB do
	describe 'validate server return codes' do
		it 'return 404 error' do
			otdb = OpenTriviaDB.new
			otdb.url = 'https://opentdb.com/apiiiii.php'
			response = otdb.get
			expect(response[:response_code]).to eq(404)
			expect(response[:response_message]).to eq('Not Found')
		end

		it 'return 503 error' do
			otdb = OpenTriviaDB.new
			otdb.url = 'http://httpstat.us/503'
			response = otdb.get
			expect(response[:response_code]).to eq(503)
			expect(response[:response_message]).to eq('Service Unavailable')
		end

		it 'return ok' do
			otdb = OpenTriviaDB.new
			response = otdb.get
			expect(response[:response_code]).to eq(0)
			expect(response[:response_message]).to eq('OK')
		end
	end
end
