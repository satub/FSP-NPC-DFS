module AI

  class Talk

    attr_reader :reactions

    def initialize(path_to_file = "lib/AI/NPC-AI/data/talk")
      files = Dir.glob("#{path_to_file}/*.txt")
      @reactions = {}
      files.each do |file|
        key = file.split("/").last.gsub(".txt", "").to_sym
        reader = File.open(file)
        @reactions[key] = []
        reader.each do |line|
          @reactions[key] << line.chomp
        end
      end
    end

  end

end
