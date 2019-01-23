require_relative "questions_database"
require_relative "question"
require_relative "user"
require_relative "replies"
require_relative "question_likes"

class QuestionFollows
  attr_accessor :id, :user_id, :question_id

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<~SQL, id) 
    SELECT 
      *
    FROM
      question_follows
    WHERE
      id = ?
    SQL

    QuestionFollows.new(data[0]) 
  end


  def self.find_by_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<~SQL, question_id) 
    SELECT 
      *
    FROM
      question_follows
    WHERE
      question_id = ?
    SQL

    QuestionFollows.new(data[0]) 
  end

  def self.followers_for_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<~SQL, question_id)
      SELECT
        users.id, users.fname, users.lname
      FROM
        users
      JOIN
        question_follows ON 
        users.id = question_follows.user_id
      WHERE
        question_id = ?
    SQL
    data.map { |datum| User.new(datum) }
  end

  def self.followed_questions_for_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<~SQL, user_id)
      SELECT
        questions.id, questions.title, questions.body, questions.user_id
      FROM
        questions
      JOIN
        question_follows ON questions.id = question_follows.question_id
      WHERE
        questions.user_id = ?
    SQL
    data.map { |datum| Question.new(datum) }
  end

  def self.most_followed_questions(n)
    data = QuestionsDatabase.instance.execute(<<~SQL, n)
      SELECT 
        questions.id, COUNT(user.id)
      FROM  
        questions
      JOIN 
        question_follows ON questions.id = question_follows.questions_id
      GROUP BY
        question_follows.user_id
      HAVING
      LIMIT n
      ORDER BY DESC
    SQL
    data.map { |datum| Question.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end
end