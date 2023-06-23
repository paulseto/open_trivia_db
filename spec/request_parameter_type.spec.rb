# frozen_string_literal: true

require_relative '../lib/open_trivia_db'

RSpec.describe OpenTriviaDB do
	describe 'validate type parameter' do
		it 'results from all types are returned when type is not set' do
			json = OpenTriviaDB.new.get({})

			list = []
			json[:questions].each do |question|
				list.append(question[:type]) unless list.include?(question[:type])
			end

			expect(list.length).to be > 1
		end

		it 'results from one type when a type id is set' do
			json = OpenTriviaDB.new.get({ type: 'multiple' })

			list = []
			json[:questions].each do |question|
				list.append(question[:type]) unless list.include?(question[:type])
			end

			expect(list.length).to eq 1
		end

		it 'results from an invalid type is set' do
			response = OpenTriviaDB.new.get({ type: 'zmultiple' })

			expect(response[:response_code]).to eq(2)
		end
	end
end
