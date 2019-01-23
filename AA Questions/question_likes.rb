require_relative "questions_database"
require_relative "question_follows"
require_relative "user"
require_relative "replies"
require_relative "question"

class QuestionsLikes
  attr_accessor :id, :user_id, :question_id

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<~SQL, id) 
    SELECT 
      *
    FROM
      question_likes
    WHERE
      id = ?
    SQL

    QuestionsLikes.new(data[0]) 
  end


  def self.find_by_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<~SQL, question_id) 
    SELECT 
      *
    FROM
      question_likes
    WHERE
      question_id = ?
    SQL

    QuestionsLikes.new(data[0]) 
  end

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end
end