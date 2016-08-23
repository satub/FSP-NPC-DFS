module AI

class Decide

  attr_reader :training_data, :attributes
  attr_accessor :decision

  def initialize(attributes, training_data)
    @attributes = attributes
    @training_data = training_data
    dec_tree = DecisionTree::ID3Tree.new(attributes, training_data, 1, :continuous)
    dec_tree.train
    @decision = dec_tree
  end

  def decision(hero, npc, analysis)
    trial = [hero.reputation, npc.personality, analysis.sum_score]
    decision = @decision.predict(trial)
  end
end

end
