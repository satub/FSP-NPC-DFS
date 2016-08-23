module AI

class Hero
  attr_accessor :reputation, :hp, :mp
  attr_reader :name

  def initialize(name = Faker::Name.name, reputation = "neutral")
    @name = name
    @reputation = reputation
    @hp = 100
    @mp = 100
  end

end

end
