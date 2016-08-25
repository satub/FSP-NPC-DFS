
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

    def autorun
      greeting = @hero.capture_output {greet}
      binding.pry
      #decide(?????)
      #should i make a discrete array of possible responses in the hero model here? should i look into yet MORE AI to get this hero to make an answer
      #i don't know so i give up!!
    end

    def greet
      puts "You are #{hero.current_reputation} hero called #{hero.name}. You approach a #{npc.current_mood} person named #{npc.name} and say:"
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
