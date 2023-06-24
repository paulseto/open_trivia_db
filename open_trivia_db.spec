# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name                  = 'open_trivia_db'
  s.version               = '1.0.1'
  s.summary               = 'Quiz questions based on the Open Trivia DB'
  s.description           = 'Retrieve questions from Open Trivia DB'
  s.authors               = ['Paul Seto']
  s.email                 = 'pseto@openlava.com'
  s.files                 = Dir['lib/**/*.rb']
  s.required_ruby_version = '~> 3'
  s.homepage              = 'https://github.com/paulseto/open_trivia_db'
  s.license               = 'MIT'
end
