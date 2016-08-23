require 'faker'

module AI

class RandomNPC < NPC

  def initialize
    @name = Faker::Name.name
    @personality = ["friendly", "suspicious", "hostile"].sample
    @converse = NPC.information_hash
  end

end


end
