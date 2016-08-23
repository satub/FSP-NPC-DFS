module AI

class Analyze

  attr_accessor :text, :blacklist, :whitelist

  #the blacklist and whitelist attributes should be fed as objects
  def initialize(text)
    @text = Highscore::Content.new(text)
    @blacklist = Highscore::Blacklist.load_file "lib/AI/NPC-AI/data/blacklist.txt"
    @whitelist = Highscore::Whitelist.load_file "lib/AI/NPC-AI/data/whitelist.txt"
  end

  def whitelist_score
    keywords = @text.content.keywords(@whitelist) do
      set :multiplier, 10
    end
    keywords.rank.collect {|k| k.weight}.inject(0, :+)
  end

  def blacklist_score
    keywords = @text.content.keywords(@blacklist)
    keywords.rank.collect {|k| k.weight}.inject(0, :+)
  end

  def score
    keywords = @text.content.keywords
    keywords.rank.collect {|k| k.weight}.inject(0, :+)
  end

  def sum_score
    if whitelist_score > blacklist_score + score
      "high"
    elsif blacklist_score <= score
      "low"
    else
      "med"
    end
  end

end

end
# al = Analyze.new("Excuse me, sir, could you please tell me where the lighthouse is?")
# puts al.whitelist_score
# puts al.blacklist_score
# puts al.score
# al2 = Analyze.new("hey babe, tell me where in the fuck the lighthouse is?")
# puts al2.whitelist_score
# puts al2.blacklist_score
# puts al2.score
# al3 = Analyze.new("oh fuck")
# puts al3.whitelist_score
# puts al3.blacklist_score
# puts al3.score
