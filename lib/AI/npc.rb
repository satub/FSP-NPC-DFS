require_relative "NPC-AI/analyze"
require_relative "NPC-AI/decide"


module AI

  class NPC
    attr_reader :name, :personality, :information

  #instead of passing data in a hash, it would be better to read all this from a file/db, based on the character
  #name or/and personality traits. This would also allow for personalized balck and whitelists
    def initialize(name, personality, information_hash)
      @name = name
      @personality = personality
      @converse = information_hash
    end

    def self.information_hash
      {
        :information => {
          :lighthouse => "It's to the South.",
          :monsters => "There are no such things, just angels.",
          :king => "Asshole, like all the other blue-bloods."
          },
        :greetings => ["Hello", "Good day", "Well met"],
        :curses => ["Bugger off, nuisance!", "You are not worthy of our time", "Begone, you foul slime-ball!", "Bitch, please"],
        :smalltalk => ["Lovely weather, isn't it?", "Oh really?", "I'm afraid it is going to rain", "Have you tried the autumn apples?"],
        :farewells => ["Take care!", "Goodbye!", "May light shine on your path"]
      }
    end

    def self.training_data
      training_data = [
        ["good", "friendly", "high", 1],
        ["good", "suspicious","high", 1],
        ["good", "hostile", "high", 1],
        ["good", "friendly", "med", 1],
        ["good", "suspicious","med", 1],
        ["good", "hostile", "med", 0],
        ["good", "friendly", "low", 1],
        ["good", "suspicious","low", 0],
        ["good", "hostile", "low", 0],
        ["neutral", "friendly", "high", 1],
        ["neutral", "suspicious","high", 1],
        ["neutral", "hostile", "high", 0],
        ["neutral", "friendly", "low", 1],
        ["neutral", "suspicious","low", 0],
        ["neutral", "hostile", "low", 0],
        ["poor", "friendly", "high", 1],
        ["poor", "suspicious","high", 0],
        ["poor", "hostile", "high", 0],
        ["poor", "friendly", "low", 0],
        ["poor", "suspicious","medium", 0],
        ["poor", "hostile", "medium", 0]]
      end

      def self.attributes
        ["hero_reputation", "npc_personality", "speech_score"]
      end

  end

end
