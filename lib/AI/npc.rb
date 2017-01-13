require_relative "NPC-AI/analyze"
require_relative "NPC-AI/decide"
require_relative "NPC-AI/information"
require_relative "NPC-AI/talk"


module AI

  class NPC
    attr_reader :name, :personality, :information_hash

  #instead of passing data in a hash, it would be better to read all this from a file/db, based on the character
  #name or/and personality traits. This would also allow for personalized balck and whitelists
    def initialize(name, personality, information_hash)
      @name = name
      @personality = personality
      @converse = information_hash
    end

    def self.information_hash
      new_hash = {}
      new_hash[:information] = Information.new.answers
      new_hash.merge!(Talk.new.reactions)
    end

    def self.training_data
      training_data = [
        [rand(66..100), rand(66..100), rand(15..50), 1],
        [rand(66..100), rand(33..66),rand(15..50), 1],
        [rand(66..100), rand(0..33), rand(15..50), 1],
        [rand(66..100), rand(66..100), rand(2..15), 1],
        [rand(66..100), rand(33..66), rand(2..15), 1],
        [rand(66..100), rand(0..33), rand(2..15), 0],
        [rand(66..100), rand(66..100), rand(-100..2), 1],
        [rand(66..100), rand(33..66),rand(-100..2), 0],
        [rand(66..100), rand(0..33), rand(-100..2), 0],
        [rand(33..66), rand(66..100), rand(15..50), 1],
        [rand(33..66), rand(33..66),rand(15..50), 1],
        [rand(33..66), rand(0..33), rand(15..50), 0],
        [rand(33..66), rand(66..100), rand(-100..2), 1],
        [rand(33..66), rand(33..66),rand(-100..2), 0],
        [rand(33..66), rand(0..33), rand(-100..2), 0],
        [rand(0..33), rand(66..100), rand(15..50), 1],
        [rand(0..33), rand(33..66),rand(15..50), 0],
        [rand(0..33), rand(0..33), rand(15..50), 0],
        [rand(0..33), rand(66..100), rand(-100..2), 0],
        [rand(0..33), rand(33..66),rand(2..15), 0],
        [rand(0..33), rand(0..33), rand(2..15), 0]]
      end

      def self.attributes
        ["hero_reputation", "npc_personality", "speech_score"]
      end

      def current_mood
        case personality
        when (0..20) then "brutally hostile"
        when (21..40) then "rather unpleasant"
        when (41..60) then "somewhat suspicious"
        when (61..80) then "carefree"
        when (81..100) then "hysterically happy"
        end
      end

  end

end
