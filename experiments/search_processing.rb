def chunk_by_phrases(key_array)
  out_array = []
  common_pre = /\Aa|the\z/i
  common_2b_verbs = /\Ais|was|were|am|are|be\z/i
  for k in (0..key_array.length-1)
    last = out_array.length - 1
    if (common_pre =~ key_array[k]) || (common_2b_verbs =~ key_array[k])
      out_array[last] = out_array[last].nil? ? key_array[k] : "#{out_array[last]} #{key_array[k]}"
    else
      out_array.push(key_array[k])
    end 
  end
  return out_array
end

@t1 = "this is a test string that guy over there was a major faggot"
@t = chunk_by_phrases(@t1.split(" "))
puts @t
