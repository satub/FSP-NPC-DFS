
module AI

class RandomNPC < NPC

  def initialize
    @name = Faker::Name.name
    @personality = rand(100)
    @converse = NPC.information_hash
  end

end


end
