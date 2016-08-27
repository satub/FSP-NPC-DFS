
module AI

  class CLI

  attr_accessor :npc, :hero

    def choose_path
      response = ""
      unless response == "EXIT"
        puts "AI test for devs only!"
        self.send(gets.chomp)
      end
    end

    def initialize(npc = RandomNPC.new, hero = Hero.new)
      @npc = npc
      @hero = hero
    end

    def run
      greet
      decide(gets.chomp)
    end

    def autorun(response = nil)
      hero.persist_seeds("Where") if hero.seeds.empty?
      greet
      if response == nil
        response = hero.create_question("Where")
      end
      puts response
      decide(response)
      result = hero.capture_output {decide(response)}
      while !result.include?("answer")
        new_response = hero.improve_question(response, result)
        hero.attempts += 1
        autorun(new_response)
      end
      hero.results(response)
    end

    def greet
      puts "You are #{hero.current_reputation} hero called #{hero.name}. You approach a #{npc.current_mood} person named #{npc.name} and say:"
    end

    def decide(response)
      al = AI::Analyze.new(response)
      decision = AI::Decide.new(NPC.attributes, NPC.training_data, :continuous)
      decision.decision(hero, npc, al) == 1 ? informative(response) : rude
      end

      def informative(response)
        triggers = AI::Analyze.new(response).find_keywords
        if !triggers.empty?
          puts "#{npc.name} answers:"
          triggers.each { |trigger| puts "#{trigger.capitalize}? #{NPC.information_hash[:information][trigger.to_sym]}".colorize(:green)}
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
