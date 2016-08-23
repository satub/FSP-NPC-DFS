module AI

  class CLI

  attr_accessor :npc, :hero

    def initialize(npc = RandomNPC.new, hero = Hero.new)
      @npc = npc
      @hero = hero
    end

    def run
      puts "You are #{hero.current_reputation} hero called #{hero.name}. You approach a #{npc.current_mood} person named #{npc.name} and say:"
      decide(gets.chomp)
    end

    def decide(response)
      al = AI::Analyze.new(response)
      decision = AI::Decide.new(NPC.attributes, NPC.training_data)
      decision.decision(hero, npc, al) == 1 ? informative(response) : rude
        #this needs to be abstracted!
      end

      def informative(response)
        blaab = response.gsub(/\W+/,"").downcase
        ##This keyword hunting needs to obviously be moved into the analyze class...why am I even typing it in here?
        answers = NPC.information_hash[:information].keys.collect do |key_word|
          blaab.scan(key_word.to_s)
        end
        if !answers.flatten.uniq.empty?
          puts "#{npc.name} answers:"
          answers.flatten.uniq.each { |answer| puts "#{answer.to_sym.capitalize}? #{NPC.information_hash[:information][answer.to_sym]}".colorize(:green)}
        else
          evasive = NPC.information_hash[:smalltalk].sample
          puts "#{npc.name} picks nose:"
          puts "Dunno about that, but #{evasive}".colorize(:light_blue)
        end
      end

      def rude
        curse = NPC.information_hash[:curses].sample
        puts "#{npc.name} says:"
        puts "#{curse}".colorize(:red)
      end


  end

end
