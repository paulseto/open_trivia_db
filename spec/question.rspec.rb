# frozen_string_literal: true

require_relative '../lib/open_trivia_db'

RSpec.describe OpenTriviaDB do
	describe 'validate question format' do
		it 'does not include correct_answer' do
			OpenTriviaDB.new.get[:questions].each do |x|
				expect(x).to include(:id)
				expect(x).to include(:category)
				expect(x).to include(:difficulty)
				expect(x).to include(:type)
				expect(x).to include(:question)
				expect(x).to include(:answers)
				expect(x).to include(:answer_key)
			end
		end
	end
end
