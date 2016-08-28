require 'stringio'
require_relative 'hero-AI/herobot'

module AI

class Hero

  attr_accessor :reputation, :hp, :mp, :past_words, :start, :attempts
  attr_reader :name

  def initialize(name = Faker::Name.name)
    @name = name
    @reputation = rand(100)
    @hp = 100
    @mp = 100
    @past_words = []
    @attempts = 1
    @start = Time.now
    @brain = AI::HeroBot.new
  end

  def current_reputation
    case reputation
    when (0..20) then "a lower than dirt"
    when (21..40) then "a lovable scoundrel of a"
    when (41..60) then "a completely middle-of-the-road"
    when (61..80) then "a more than decent"
    when (81..100) then "an obnoxiously perfect"
    end
  end

  def capture_output
    current_stdout = $stdout
    $stdout = StringIO.new
    yield
      $stdout.string
    ensure
      $stdout = current_stdout
  end

  def create_question(phrase)
    @brain.talk(phrase)
  end

  def improve_question(question, response)
    populate_data(question, response)
    question_tree = DecisionTree::ID3Tree.new(["no_angry_response"], past_words, 0, :discrete)
    rating = 0
    new_question = ""
    until rating > 0 && !new_question.include?("would")
      new_question = create_question(response)
      rating = rate_question(new_question, question_tree)
    end
    new_question
  end

  def populate_data(question, response)
    question.split(" ").each do |word|
      response.include?("says") ? past_words.push([word, 1]) :  past_words.push([word, 0])
    end
  end

  def rate_question(question, question_tree)
    good_words = 0
    bad_words = 0
    question.split(" ").each do |word|
      question_tree.predict(word) == 1 ? bad_words += 1 : good_words += 1
    end
    good_words - bad_words
  end

  def results(question)
    puts "Attempts: #{self.attempts}. Total time: #{Time.now - start}. Winner: #{question}"
  end


end

end
