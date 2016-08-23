module AI

  class CLI

  attr_accessor :npc, :hero

    def initialize(npc = RandomNPC.new, hero = Hero.new)
      @npc = npc
      @hero = hero
    end

    def run
      puts "You are a hero called #{hero.name}. You approach a #{npc.personality} person named #{npc.name} and say:"
      decide(gets.chomp)
    end

    def decide(response)
      al = AI::Analyze.new(response)
      # puts al.sum_score
      decision = AI::Decide.new(NPC.attributes, NPC.training_data)
      decision.decision(hero, npc, al) == 1 ? informative : rude
        #this needs to be abstracted!
      end

      def informative
        puts "#{npc.name} answers:"
        puts "#{NPC.information_hash[:information][:lighthouse]}".colorize(:green)
      end

      def rude
        index = NPC.information_hash[:curses].sample
        binding.pry
        puts "#{npc.name} says:"
        puts "#{NPC.information_hash[:curses][index]}".colorize(:red)
      end


  end

end
