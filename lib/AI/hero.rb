require 'stringio'

module AI

class Hero
  attr_accessor :reputation, :hp, :mp
  attr_reader :name

  def initialize(name = Faker::Name.name)
    @name = name
    @reputation = rand(100)
    @hp = 100
    @mp = 100
  end

<<<<<<< HEAD
  def current_reputation
    case reputation
    when (0..20) then "a lower than dirt"
    when (21..40) then "a lovable scoundrel of a"
    when (41..60) then "a completely middle-of-the-road"
    when (61..80) then "a more than decent"
    when (81..100) then "an obnoxiously perfect"
    end
=======
  def capture_output
    current_stdout = $stdout
    $stdout = StringIO.new
    yield
    $stdout.string
  ensure
    $stdout = current_stdout
>>>>>>> responsive-hero
  end

end

end
