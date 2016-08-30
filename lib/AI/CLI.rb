
module AI

  class CLI

  attr_accessor :npc, :hero, :action, :analysis

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
      input = next_step
      until !/exit/.match(input.downcase).nil?
        decide(input) unless @action == "move_on"
        if @action == "continue"
          input = next_step
        else
          say_bye unless @action == "rejected"
          @action = "continue"
          swap_npc
          greet
          input = next_step
        end
      end
      say_bye
    end

    def autorun
      hero.persist_seeds("Where")
      greet
      response = hero.create_question("Where")
      puts response
      decide(response)
    end

    def greet
      puts "You are #{hero.current_reputation} hero called #{hero.name}. You approach a #{npc.current_mood} person named #{npc.name}."
    end

    def next_step
      puts "You say:"
      input = gets.chomp
      ##regex should be switched to analyze categorize and recognize a farewell function
      !/bye(\W|\b)/.match(input.downcase).nil? ? @action = "move_on" : @action = "continue"
      input
    end

    def say_bye
      puts "#{npc.name} waves you off:"
      puts "#{NPC.information_hash[:farewells].sample}".colorize(:light_blue)
    end

    def decide(response)
      @analysis = AI::Analyze.new(response)
      decision = AI::Decide.new(NPC.attributes, NPC.training_data)
      decision.decision(hero, npc, @analysis) == 1 ? informative(response) : rude
      puts "Your response score was: #{@analysis.total}"
    end

    def informative(response)
      triggers = @analysis.find_keywords
      # analysis.categorize
      if !triggers.empty?
        puts "#{npc.name} answers:"
        triggers.each { |trigger| puts "#{trigger.capitalize}? #{NPC.information_hash[:information][trigger.downcase.to_sym]}".colorize(:green)}
        hero.inflate_ego(@analysis.total/20) if @analysis.total > 20
      else
        evasive = NPC.information_hash[:smalltalk].sample
        puts "#{npc.name} picks nose:"
        puts "Dunno about that, but #{evasive}".colorize(:light_blue)
        hero.inflate_ego(@analysis.total/30) if @analysis.total> 30
        hero.deflate_ego(@analysis.total/10) if @analysis.total < 0
      end
    end

    def rude
      curse = NPC.information_hash[:curses].sample
      puts "#{npc.name} says:"
      puts "#{curse}".colorize(:red)
      @action = "rejected"
      # binding.pry
      hero.deflate_ego(@analysis.total/10) if @analysis.total < 0
    end


  end

end
