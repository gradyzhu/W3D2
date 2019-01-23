require_relative "questions_database"
require_relative "question_follows"
require_relative "user"
require_relative "question"
require_relative "question_likes"

class Reply
  attr_accessor :id, :body, :user_id, :question_id, :parent_reply_id

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<~SQL, id) 
    SELECT 
      *
    FROM
      replies
    WHERE
      id = ?
    SQL

    Reply.new(data[0]) 
  end

  def self.find_by_id(user_id)
    data = QuestionsDatabase.instance.execute(<<~SQL, user_id) 
    SELECT 
      *
    FROM
      replies
    WHERE
      user_id = ?
    SQL

    Reply.new(data[0]) 
  end

  def self.find_by_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<~SQL, question_id) 
    SELECT 
      *
    FROM
      replies
    WHERE
      question_id = ?
    SQL

    Reply.new(data[0]) 
  end

  def initialize(options)
    @id = options['id']
    @body = options['body']
    @user_id = options['user_id']
    @question_id = options['question_id']
    @parent_reply_id = options['parent_reply_id']
  end

  def author
    User.find_by_id(user_id)
  end

  def question
    Question.find_by_question_id(question_id)
  end

  def parent_reply
    Reply.find_by_id(parent_reply_id)
  end

  def child_replies
    Reply.find_by_id(id)
  end
end