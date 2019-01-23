require_relative "questions_database"
require_relative "question_follows"
require_relative "user"
require_relative "replies"
require_relative "question_likes"

class Question
  attr_accessor :id, :title, :body, :user_id

  def self.find_by_id(id)
      data = QuestionsDatabase.instance.execute(<<~SQL, id)
      SELECT 
        *
      FROM
        questions
      WHERE
        id = ?
      SQL

      Question.new(data[0])
  end

  def self.find_by_author_id(user_id)
    data = QuestionsDatabase.instance.execute(<<~SQL, user_id)
    SELECT 
      *
    FROM
      questions
    WHERE
      user_id = ?
    SQL

    Question.new(data[0])
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end

  def author
    User.find_by_id(user_id)
  end

  def replies
    Reply.find_by_question_id(id)
  end

  def followers
    QuestionFollows.followers_for_question_id(id)
  end
end
