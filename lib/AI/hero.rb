require 'stringio'
require_relative 'hero-AI/markov-responder'

module AI

  class Hero

    include MarkovResponder

    attr_accessor :reputation, :hp, :mp, :seeds, :past_questions
    attr_reader :name

    def initialize(name = Faker::Name.name)
      @name = name
      @reputation = rand(100)
      @hp = 100
      @mp = 100
      @seeds = {}
      @past_questions = []
    end

    def persist_seeds(first_word)
      @seeds = make_hash(collect_seeds('lib/AI/hero-AI/got.txt', first_word.length))
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

    def create_question(first_word)
      markov(self.seeds, first_word)
    end

    def deflate_ego(neg_points)
      new_reputation = @reputation + neg_points
      new_reputation < 0 ? @reputation = 0 : @reputation = new_reputation
      puts "Your ego has been deflated! Reputation score now: #{@reputation}"
    end

    def inflate_ego(pos_points)
      @reputation += pos_points
      puts "Your ego has been inflated! Reputation score now: #{@reputation}"
    end

  end

end
