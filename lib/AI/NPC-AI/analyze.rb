module AI

  class Analyze

    attr_accessor :text, :blacklist, :whitelist, :matches
    attr_reader :total

    #the blacklist and whitelist attributes should be fed as objects
    def initialize(text)
      match_array = Information.new
      @matches = match_array.answers.keys.collect {|key| key.to_s}
      # @regex_matches = match_array.answers.keys.collect {|key| "#{key.to_s}\\w*"}

      @blacklist = Highscore::Blacklist.load_file "lib/AI/NPC-AI/data/blacklist.txt"
      @whitelist = Highscore::Whitelist.load_file "lib/AI/NPC-AI/data/whitelist.txt"
      @text = Highscore::Content.new text, @blacklist
      # binding.pry
      @text.configure do
        set :stemming, true
        set :upper_case, 2
      end
    end

    def find_keywords
      filter = LanguageFilter::Filter.new(matchlist: @matches)
      # filter2 = LanguageFilter::Filter.new(matchlist: @regex_matches)
      # filter2.matched(@text.content)
      filter.matched(@text.content)
    end

    def score
      keywords = @text.content.keywords
      keywords.rank.collect {|k| k.weight}.inject(0, :+)
    end

    def whitelist_score
      keywords = @text.content.keywords(@whitelist) do
        set :multiplier, 10
        set :stemming, true
        set :upper_case, 1
      end
      keywords.rank.collect {|k| k.weight}.inject(0, :+)
    end

    def blacklist_score
      filter = LanguageFilter::Filter.new(matchlist: @blacklist.words)
      # sanitized = filter.sanitize(@text.content).gsub(/\s\*{4}\s?/,"")
      filter.matched(@text.content).size * -50
    end

    def sum_score
        @total = whitelist_score + blacklist_score + score
        puts @total
        @total
    end

  end

end
