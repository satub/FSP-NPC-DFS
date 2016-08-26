module AI

  class Information

    attr_reader :answers

    def initialize(path_to_file = "lib/AI/NPC-AI/data/information.txt")
      file = File.open(path_to_file)
      @answers = {}
      file.each_with_object(@answers) do |line, answers|
        info = line.chomp.split(" => ")
        answers[info[0].to_sym] = info[1]
      end
    end

  end

end
