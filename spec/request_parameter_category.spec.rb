# frozen_string_literal: true

require_relative '../lib/open_trivia_db'

RSpec.describe OpenTriviaDB do
	describe 'validate category parameter' do
		it 'results from all categories are returned when cateogry is not set' do
			json = OpenTriviaDB.new.get({})
			list = []
			json[:questions].each do |question|
				list.append(question[:category]) unless list.include?(question[:category])
			end
			expect(list.length).to be > 1
		end

		it 'results from one category when a category id is set' do
			json = OpenTriviaDB.new.get({ category: 9 })
			list = []
			json[:questions].each do |question|
				list.append(question[:category]) unless list.include?(question[:category])
			end
			expect(list.length).to eq 1
		end

		it 'results from an invalid category is set' do
			response = OpenTriviaDB.new.get({ difficulty: 'generalx' })
			expect(response[:response_code]).to eq(2)
		end
	end
end
