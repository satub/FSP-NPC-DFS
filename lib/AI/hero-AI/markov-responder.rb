module AI

module MarkovResponder

  #add: possibility for seed (maybe start CLI with seed)
  #length of average question in English?
  #how to add in needed key when question format is already set
  #probably make a method that persists or saves the seed hash

  def markov(seed_hash, first_word)

    starters = seed_hash.select{|k, v| k[0..6].include?(first_word)}
  	start_seed = starters.keys.sample
    master_string = start_seed.dup if start_seed.frozen?

  	120.times do
      seed = master_string[-10..-1]
  		master_string << seed_hash[seed].sample
  	end

  	master_string + "?"

  end

  def make_hash(seeds)
  	seed_hash = {}
  	seeds.each{|seed, index| seed_hash[seed] = []}
  	seeds.each_with_index do |seed, index|
  		if index < seeds.length - 1
  			next_letter = seeds[index + 1][-1]
  			seed_hash[seed].push(next_letter)
  		##else condition below takes care of edge cases by looping to the beginning
  		else
  			seed_hash[seed].push(" ")
  			seed = seed[1..-1] + " "
  			i = 0
  			while seed != seeds[0]
  				next_letter = seeds[i][0]
  				seed_hash[seed] ? seed_hash[seed].push(next_letter) : seed_hash[seed] = [next_letter]
  				seed = seed[1..-1] + next_letter
  				i += 1
  			end
  		end
  	end
  	seed_hash
  end

  def collect_seeds(file_path, level)
    text = File.read(file_path)
  	array = text.split("")
  	seeds = array.collect.with_index do |letter, index|
  		if index < array.length - level + 1
  			#this conditional ensures that just the text is captured here.
  			chunk = 1
  			final_seed = letter
  			until chunk == level
  				final_seed += "#{array[index+chunk]}"
  				chunk += 1
  			end
  		end
  		final_seed
  	end
  	seeds.compact! #removes the "nils" collect returns when i didn't operate on items
  end

end

end
