# Open Trivia DB
An interface to query [Open Trivia DB](https://opentdb.com/) and return questions.  Answers can be encrypted using one of two answer key generators included in the gem or a custom generator can be written.

See [Open Trivia API](https://opentdb.com/api_config.php) to see parameters and valid values.

**Notes**
- The Open Trivia API encryption parameter has not been included.
- Fake data has been used for `question` and `answer` fields.

## Installation
Update `Gemfile`
```
gem 'open_trivia_db'
```
Install gem
```
gem install open_trivia_db

or

bundle update
```

## Examples

### Default Query

The default query has no parameters and returns 10 questions from any category of any difficulty and any type of question.
```
require 'open_trivia_db'
require 'json'

otdb = OpenTriviaDB.new
response = otdb.get #default 10 questions returned and same as `otdb.get({amount: 10})`
puts JSON.pretty_generate(response)
```
#### Output
```
{
  "response_code": 0,
  "response_message": "OK",
  "params": {
    "amount": 10
  },
  "questions": [
    {
      "id": 1,
      "category": "Entertainment: Cartoon & Animations",
      "difficulty": "easy",
      "type": "multiple",
      "question": "tenetur eos dolores consequuntur doloremque iure omnis harum et dolore sit maxime omnis fuga commodi sunt fugiat.",
      "answer_key": 3,
      "answers": [
        "accusantium quis",
        "ducimus rerum",
        "voluptate culpa",
        "delectus eligendi"
      ]
    },
    {
      "id": 2,
      "category": "General Knowledge",
      "difficulty": "medium",
      "type": "multiple",
      "question": "et vitae quod dolorem quos dolorem rem dolores debitis.",
      "answer_key": 0,
      "answers": [
        "ex",
        "quae",
        "dolor",
        "ad"
      ]
    },

	···

    {
      "id": 10,
      "category": "Entertainment: Video Games",
      "difficulty": "medium",
      "type": "multiple",
      "question": "aut doloribus error veritatis quod hic dolorem quaerat perspiciatis enim et id at et repellendus voluptas itaque voluptatem quisquam eveniet minima.",
      "answer_key": 3,
      "answers": [
        "eos.",
        "est",
        "qui",
        "esse aut"
      ]
    }
  ]
}
```
The `answer_key` represent the zero-based index location of the correct answer in the `answers` array.

### Complicated Query
Return a set of hard multiple choice questions from the Mythology category.
```
require 'open_trivia_db'
require 'json'

parameters = {
	category: 15,
	difficulty: 'easy',
	type: 'multiple',
	amount: 5
}

otdb = OpenTriviaDB.new
response = otdb.get parameters
puts JSON.pretty_generate(response)
```
#### Output
```
{
  "response_code": 0,
  "response_message": "OK",
  "params": {
    "category": 15,
    "difficulty": "easy",
    "type": "multiple",
    "amount": 5
  },
  "questions": [
    {
      "id": 1,
      "category": "Entertainment: Video Games",
      "difficulty": "easy",
      "type": "multiple",
      "question": "saepe maxime iste earum.",
      "answer_key": 3,
      "answers": [
        "ut",
        "enim",
        "doloremque",
        "explicabo"
      ]
    },
    {
      "id": 2,
      "category": "Entertainment: Video Games",
      "difficulty": "easy",
      "type": "multiple",
      "question": "beatae et quia esse molestiae alias dignissimos aut consectetur non deleniti aliquam commodi impedit eum quaerat repellat ut asperiores.",
      "answer_key": 1,
      "answers": [
        "et qui",
        "temporibus ut",
        "placeat perspiciatis numquam",
        "consequatur recusandae eius ut"
      ]
    },
    {
      "id": 3,
      "category": "Entertainment: Video Games",
      "difficulty": "easy",
      "type": "multiple",
      "question": "itaque officia animi eaque ut consequatur rerum qui fugiat nihil nulla cumque.",
      "answer_key": 1,
      "answers": [
        "quaerat",
        "doloribus",
        "maiores",
        "molestias"
      ]
    },
    {
      "id": 4,
      "category": "Entertainment: Video Games",
      "difficulty": "easy",
      "type": "multiple",
      "question": "et dignissimos voluptates voluptatem porro vel officiis quia repellendus voluptatum omnis ducimus.",
      "answer_key": 2,
      "answers": [
        "est enim",
        "deserunt dicta",
        "eos id",
        "assumenda perspiciatis"
      ]
    },
    {
      "id": 5,
      "category": "Entertainment: Video Games",
      "difficulty": "easy",
      "type": "multiple",
      "question": "id a repellat sunt architecto minus enim distinctio consequatur rem quae iste sed voluptas itaque fuga nam beatae.",
      "answer_key": 1,
      "answers": [
        "id est quisquam",
        "facilis soluta",
        "dolore est",
        "architecto nulla"
      ]
    }
  ]
}
```
### Encrypting the answer
The examples above have the `answer_key` unencrypted and can be easily viewed by inquisitive people. Two encrypting algoritms (`LeadingDigitsKeyGenerator` and `CategoryTextKeyGenerator`) are included.

Set the generator property to encrypt the `answer_key`.

```
require 'open_trivia_db'
require 'json'

otdb = OpenTriviaDB.new
otdb.generator = LeadingDigitsKeyGenerator
response = otdb.get({amount: 2})
puts JSON.pretty_generate(response)
```
#### Output
```
{
  "response_code": 0,
  "response_message": "OK",
  "params": {
    "amount": 2
  },
  "questions": [
    {
      "id": 1,
      "category": "General Knowledge",
      "difficulty": "easy",
      "type": "multiple",
      "question": "fugit deleniti architecto aut voluptatem corporis incidunt corrupti voluptas aut exercitationem non.",
      "answer_key": "8692994439",
      "answers": [
        "sed",
        "a",
        "illum",
        "illo"
      ]
    },
    {
      "id": 2,
      "category": "Sports",
      "difficulty": "easy",
      "type": "multiple",
      "question": "quibusdam in animi iusto repellat placeat reprehenderit id nisi quam voluptatem aperiam consectetur.",
      "answer_key": "9982538408",
      "answers": [
        "quia",
        "qui",
        "et distinctio",
        "eum nemo"
      ]
    }
  ]
}
```
### Custom Answer Key Generator
Suppose you want to build a key generator where the answer key contains the correct answer based on order of the questions. For example, the answer to question #5 is in the 5th position of the answer key. From the example output above, the question `id` represents the order of the question in a quiz.

The custom key generator will need to include the `GenerateAnswerKey` interface which requires overwriting `update_answer_key` and `decrypt_answer_key` methods. The `decrypt_answer_key` method only needs to be implemented if it will be called.
```
require 'open_trivia_db'
require 'json'

class QuestionIndexKeyGenerator
	include GenerateAnswerKey

	def self.update_answer_key(question)
		answer = question[:answer_key]
		location = question[:id].to_i % 10
		question[:answer_key] = case location
        when 0
	        answer.to_s + GenerateAnswerKey.get_random_key(9)
        when 9
        	GenerateAnswerKey.get_random_key(9) + answer.to_s
        else
        	GenerateAnswerKey.get_random_key(location) +
        	answer.to_s +
        	GenerateAnswerKey.get_random_key(9 - location)
        end
	end

	def self.decrypt_answer_key(question)
		location = question[:id] % 10
		question[:answer_key][location].to_i
	end
end

otdb = OpenTriviaDB.new
otdb.generator = QuestionIndexKeyGenerator
response = otdb.get({amount: 5})
puts JSON.pretty_generate(response)
```
#### Output
```
{
  "response_code": 0,
  "response_message": "OK",
  "params": {
    "amount": 5
  },
  "questions": [
    {
      "id": 1,
      "category": "Science: Computers",
      "difficulty": "easy",
      "type": "multiple",
      "question": "quos voluptatem molestiae quis ducimus fuga alias voluptas ut rem dolorem ut molestiae autem dignissimos perferendis.",
      "answer_key": "7188945803",
      "answers": [
        "ea",
        "maxime",
        "officiis",
        "tenetur"
      ]
    },
    {
      "id": 2,
      "category": "Entertainment: Film",
      "difficulty": "medium",
      "type": "multiple",
      "question": "quas enim voluptatem sit inventore aliquid est rerum hic voluptate consequatur blanditiis odit delectus nemo quis ea odio.",
      "answer_key": "5203427496",
      "answers": [
        "id libero consequatur",
        "iste alias accusamus",
        "eos aliquam sint",
        "rerum in dicta"
      ]
    },
    {
      "id": 3,
      "category": "Entertainment: Japanese Anime & Manga",
      "difficulty": "hard",
      "type": "multiple",
      "question": "unde officiis est est et dolorum corporis necessitatibus amet enim ab dolorem incidunt eligendi voluptates doloribus consequuntur qui quia cum.",
      "answer_key": "7232564490",
      "answers": [
        "commodi veniam",
        "voluptatibus error",
        "impedit necessitatibus",
        "temporibus quisquam"
      ]
    },
    {
      "id": 4,
      "category": "Entertainment: Video Games",
      "difficulty": "easy",
      "type": "multiple",
      "question": "officiis nesciunt blanditiis ratione recusandae eos veniam beatae maxime saepe explicabo.",
      "answer_key": "9854192302",
      "answers": [
        "aspernatur sit",
        "placeat",
        "suscipit sint",
        "quia sit"
      ]
    },
    {
      "id": 5,
      "category": "Science: Computers",
      "difficulty": "hard",
      "type": "multiple",
      "question": "quisquam eum sunt dolores dolor autem omnis porro fuga aut et repellendus alias.",
      "answer_key": "3763208086",
      "answers": [
        "iusto",
        "quia",
        "dolorem",
        "ducimus"
      ]
    }
  ]
}
```
