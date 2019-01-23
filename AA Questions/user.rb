require_relative "questions_database"
require_relative "question_follows"
require_relative "question"
require_relative "replies"
require_relative "question_likes"
class User
  attr_accessor :id, :fname, :lname

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<~SQL, id) 
    SELECT 
      *
    FROM
      users
    WHERE
      id = ?
    SQL

    User.new(data[0]) 
  end

  def self.find_by_name(fname, lname)
    data = QuestionsDatabase.instance.execute(<<~SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
    SQL

    data.map { |datum| User.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def authored_questions
    Question.find_by_author_id(id)
  end

  def authored_replies
    Reply.find_by_id(id)
  end

  def followed_questions 
    QuestionFollows.followed_questions_for_user_id(user_id)
  end
end