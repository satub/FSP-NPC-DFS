require 'stringio'
require 'engtagger'

module AI

  class Hero

# <<<<<<< HEAD
    # include MarkovResponder

#     attr_accessor :reputation, :hp, :mp, :seeds, :past_questions
#     attr_reader :name
#
#     def initialize(name = Faker::Name.name)
#       @name = name
#       @reputation = rand(100)
#       @hp = 100
#       @mp = 100
#       @seeds = {}
#       @past_questions = []
#     end
#
#     def persist_seeds(first_word)
#       @seeds = make_hash(collect_seeds('lib/AI/hero-AI/got.txt', first_word.length))
#     end
# =======
  attr_accessor :reputation, :hp, :mp, :tag_hash, :past_words, :start, :attempts
  attr_reader :name

  def initialize(name = Faker::Name.name)
    @name = name
    @reputation = rand(100)
    @hp = 100
    @mp = 100
    @tag_hash = {}
    @past_words = []
    @attempts = 1
    @start = Time.now
    build_tag_hash
  end

  def build_tag_hash
    tagged = File.read('lib/AI/hero-AI/taggedGoT.txt')
    ['uh', 'wdt', 'wp', 'wps', 'wrb', 'md', 'nn', 'nns', 'vb', 'rb', 'vbd', 'to', 'in', 'cc'].each do |key|
      tag_hash[key] = tagged.scan(/<#{key}>(.*?)<\/#{key}>/).flatten
    end
    flatten_overlaps
  end
# >>>>>>> improve-markov

  def flatten_overlaps
    tag_hash['questions'] = []
    tag_hash['wdt'].each{|value| tag_hash['questions'] << value}
    tag_hash['wps'].each{|value| tag_hash['questions'] << value}
    tag_hash['wrb'].each{|value| tag_hash['questions'] << value}
    tag_hash['wdt'].each{|value| tag_hash['questions'] << value}
    tag_hash['nns'].each{|value| tag_hash['nn'] << value}
    tag_hash['in'].each{|value| tag_hash['to'] << value}
    tag_hash['cc'].each{|value| tag_hash['to'] << value}
    tag_hash.each do |k, v|
      v.map!{|word| word.downcase}
    end
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

# <<<<<<< HEAD
#     def create_question(first_word)
#       markov(self.seeds, first_word)
#     end

    def deflate_ego(neg_points)
      new_reputation = @reputation + neg_points
      new_reputation < 0 ? @reputation = 0 : @reputation = new_reputation
      puts "Your ego has been deflated! Reputation score now: #{@reputation}"
    end

    def inflate_ego(pos_points)
      @reputation += pos_points
      puts "Your ego has been inflated! Reputation score now: #{@reputation}"
    end

  # end
# =======
  def create_question
    question = ""
    question << tag_hash['uh'].sample.capitalize
    question << ", "
    question << tag_hash['questions'].sample + " "
    question << tag_hash['md'].sample + " "
    question << tag_hash['nn'].sample + " "
    question << tag_hash['vb'].sample + "? "
    question << tag_hash['nn'].sample.capitalize + " "
    question << tag_hash['rb'].sample + " "
    question << tag_hash['vbd'].sample + " "
    question << tag_hash['to'].sample + " "
    question << tag_hash['nn'].sample + "."
  end


  def improve_question(question, response)
    populate_data(question, response)
    question_tree = DecisionTree::ID3Tree.new(["no_angry_response"], past_words, 0, :discrete)
    rating = 0
    until rating > 0
      new_question = create_question
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
# >>>>>>> improve-markov

end
