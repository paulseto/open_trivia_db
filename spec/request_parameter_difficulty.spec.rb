# frozen_string_literal: true

require_relative '../lib/open_trivia_db'

RSpec.describe OpenTriviaDB do
	describe 'validate difficulty parameter' do
		it 'results from all difficulties are returned when difficulty is not set' do
			json = OpenTriviaDB.new.get({amount: 40})
			list = []
			json[:questions].each do |question|
				list.append(question[:difficulty]) unless list.include?(question[:difficulty])
			end
			expect(list.length).to be > 1
		end

		it 'results from one difficulty when a difficulty id is set' do
			json = OpenTriviaDB.new.get({ difficulty: 'hard' })
			list = []
			json[:questions].each do |question|
				list.append(question[:difficulty]) unless list.include?(question[:difficulty])
			end
			expect(list.length).to eq 1
		end

		it 'results from an invalid difficulty is set' do
			response = OpenTriviaDB.new.get({ difficulty: 'eeasy' })
			expect(response[:response_code]).to eq 2
		end
	end
end
