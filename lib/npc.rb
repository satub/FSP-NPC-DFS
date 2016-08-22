class NPC
  attr_reader :name, :personality, :information

  #instead of passing data in a hash, it would be better to read all this from a file/db, based on the character
  #name or/and personality traits. This would also allow for personalized balck and whitelists
  def initialize(name, personality, information_hash)
    @name = name
    @personality = personality
    @converse = information_hash
  end

end
