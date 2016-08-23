module AI

  class CLI

  attr_accessor :npc, :hero

    def initialize(npc = RandomNPC.new, hero = Hero.new)
      @npc = npc
      @hero = hero
    end

    def run
      binding.pry
    end

  end

end
