require 'date'

class NumberToWordOpt

  def letter_combinations(digits)
    time_start = Time.now()
    #return if number not valid
    return [] if digits.nil? || digits.length != 10 || digits.split('').select{|a|(a.to_i == 0 || a.to_i == 1)}.length > 0
    #number to letters mapping
    letters = {"2" => ["a", "b", "c"],"3" => ["d", "e", "f"],"4" => ["g", "h", "i"],"5" => ["j", "k", "l"],"6" => ["m", "n", "o"],"7" => ["p", "q", "r", "s"],"8" => ["t", "u", "v"],"9" => ["w", "x", "y", "z"]}

    # Read dictionary file and hold all values in a array
    dictionary = {}
    for i in (1..30)
      dictionary[i] = []
    end
    file_path = "dictionary.txt"
    File.foreach( file_path ) do |word|
      dictionary[word.length] << word.chop.to_s.downcase
    end

    keys = digits.chars.map{|digit|letters[digit]}

    results = {}
    total_number = keys.length - 1 # total numbers
    #Loo through all letters and get matching records with dictionary
    for i in (2..total_number - 2)
      first_array = keys[0..i]
      next if first_array.length < 3
      second_array = keys[i + 1..total_number]
      next if second_array.length < 3
      first_combination = first_array.shift.product(*first_array).map(&:join) # Get product of arrays #get_combination(first_array, dictionary)#
      next if first_combination.nil?
      second_combination = second_array.shift.product(*second_array).map(&:join)
      next if second_combination.nil?
      results[i] = [(first_combination & dictionary[i+2]), (second_combination & dictionary[total_number - i +1])] # get common values from arrays
    end
    #arrange words like we need as a output
    final_words = []
    results.each do |key, combinataions|
      next if combinataions.first.nil? || combinataions.last.nil?
      combinataions.first.product(combinataions.last).each do |combo_words|
        final_words << combo_words
      end
    end
    # for all numbers
    final_words << (keys.shift.product(*keys).map(&:join) & dictionary[11]).join(", ") # matche with all character
    time_end = Time.now()
    puts "Time #{time_end.to_f - time_start.to_f}"
    final_words
  end

end

final_words = NumberToWordOpt.new().letter_combinations("2282668687")
print final_words