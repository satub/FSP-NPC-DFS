
module AI

  class CLI

  attr_accessor :npc, :hero, :action

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
      @action = "continue"
    end

    def swap_npc(npc = RandomNPC.new)
      @npc = npc
    end

    def run
      greet
      decide(gets.chomp)
    end

    def gamerun
      input = ""
      greet
      input = gets.chomp
      until input.downcase == "exit"
        decide(input)
        if @action == "continue"
          input = next_step
        else
          @action = "continue"
          swap_npc
          greet
          input = gets.chomp
        end
      end
    end

    def autorun
      hero.persist_seeds("Where")
      greet
      response = hero.create_question("Where")
      puts response
      decide(response)
    end

    def greet
      puts "You are #{hero.current_reputation} hero called #{hero.name}. You approach a #{npc.current_mood} person named #{npc.name} and say:"
    end

    def next_step
      puts "Anything else?"
      gets.chomp
    end

    def decide(response)
      al = AI::Analyze.new(response)
      decision = AI::Decide.new(NPC.attributes, NPC.training_data)
      decision.decision(hero, npc, al) == 1 ? informative(response) : rude
    end

    def informative(response)
      triggers = AI::Analyze.new(response).find_keywords
      if !triggers.empty?
        puts "#{npc.name} answers:"
        triggers.each { |trigger| puts "#{trigger.capitalize}? #{NPC.information_hash[:information][trigger.downcase.to_sym]}".colorize(:green)}
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
      @action = "rejected"
    end


  end

end
