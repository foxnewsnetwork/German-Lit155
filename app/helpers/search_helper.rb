module SearchHelper

  # This function will be the most ambitious son-of-a-bitch thing I write today
  # Takes a string of essentially anything
  # returns an array of rumor_id ordered by proximity to the keywords with added weight on creation date
  # Because of the obvious critical nature of this function, all version of this will be kept
  def search(keywords)
    keyword_array = keywords.split(" ")
   	all_rumors = Rumor.all
		rumor_val = []
		all_rumors.each do |rumor|
			value = weigh_by_content(keyword_array, rumor)
			rumor_val.push( [rumor.id , value] )
		end
    rumor_val.sort! do |a,b|
      b.value <=> a.value
    end
    
    return ActiveSupport::OrderedHash[rumor_val]
  end
  
  private
    # Assigns a value based upon how many times the key words show up
    def weigh_by_content(key_array_in, rumor)
			key_array = chunk_by_phrases(key_array_in)
      value = key_array.length
      total = 0
      content_string = rumor.content
      for j in 0..value-1
        value -= j
        regex = /#{key_array[0..j].join(" ")}/i
        total += value * content_string.scan(regex).length
        return total if total > 0
      end
      return 0
    end
    
    # chunks together common phrases like "is a", "was a", etc. to the following object
     def chunk_by_phrases(key_array)
      out_array = []
      common_pre = /\Aa|the\z/i
      common_2b_verbs = /\Ais|was|were|am|are|be\z/i
      for k in (0..key_array.length-1)
        last = out_array.length - 1
        if (common_pre =~ key_array[k]) || (common_2b_verbs =~ key_array[k])
          out_arra  y[last] = out_array[last].nil? ? key_array[k] : "#{out_array[last]} #{key_array[k]}"
        else
          out_array.push(key_array[k])
        end 
      end
      return out_array
    end
    
		# Not implemented yet.
		# The idea behind this one is that dates are specifically searched for
    def weigh_by_date(key_array, rumor)
    	return 0
    end

		# Not implemented yet
		# This function ought to extract anything that looks like a date in the content
		def extract_dates(rumor)
			
    	return 0
		end
    
		# Not implemented yet
		# This here should tap in the model and retrieve the usual search popularity of given rumors
    def weigh_by_frequency(rumor)
    
    	return 0
    end
    
    # Not implemented yet
		# This rig ought to correct for improper spellings and pull in rumors with similar spellings
		# Seriously, get a gem library for this one
    def weigh_for_spelling(key_array, rumor)
    
    	return 0
    end
    
end
