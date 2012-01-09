# == Schema Information
#
# Table name: tag_records
#
#  id         :integer(4)      not null, primary key
#  person_id  :integer(4)
#  tag        :string(255)
#  count      :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class TagRecord < ActiveRecord::Base
	belongs_to :person
	
	attr_accessible :person_id, :tag
	
	def self.build_with_magic( person, rumor )
		# Using activerecord-import to do this!
		# Step 1: initialize
		raw_tag_vec = TagRecord.chunk_ignore_parse( rumor.content )
		tag_hash = TagRecord.collapse_hash( raw_tag_vec )
		
		# Step 2: parse out
		tag_vec = []
		person_vec = []
		tag_hash.each do |key, value|
			tag_vec << key
		end
		
		# Step 3: refine count
		TagRecord.where(:person_id => person.id, :tag => tag_vec ).find_each do |tr|
			tag_hash[tr.tag] += tr.count unless tag_hash[tr.tag].nil?
		end
		
		# Step 3.5: Creating the value_vec
		value_vec = []
		tag_hash.each do |tag, count|
			value_vec << [ person.id, tag, count ]
		end
	
		# Step 4: importing
		TagRecord.import( [:person_id, :tag, :count], value_vec,  :on_duplicate_key_update => [:count], :validate => false )
	end
	
	def self.ignore_parse( string )
		modifiers = ["a", "the","of","and","or","either","neither","nor"]
		fag_verbs = ["is","are","am","were","be","has","have","having","had","been","to","from","in","as","isn't","wasn't","weren't","ain't","won't","will","hasn't","haven't","hadn't","did","do","didn't","don't","with"]
		fag_adverbs = ["should","would","could","can","shouldn't","wouldn't","couldn't","can't","cannot",
			"very","really","seriously","totally","highly","extremely","completely","entirely","absolutely",
			"majorly","vastly", "generally","slightly","kinda","sorta","maybe","hopelessly","hopefully","incredibly","currently"]
		pronouns = ["I","you","he","she","they","them","these","those","that","this","her","him","his","their","theirs","your","yours","me","mine"]
		
		combine = modifiers + fag_verbs + fag_adverbs + pronouns
 
		str_vec = string.split(" ")
		mod_str = [ ]
		str_vec.each do |str|
			mod_str.push( str ) unless combine.include?( str )
		end
		return mod_str
	end	
	
	# Parses the string into chunks
	def self.chunk_parse( string )
		modifiers = ["a", "the","of","and","or","either","neither","nor"]
		fag_verbs = ["is","are","am","were","be","has","have","having","had","been","to","from","in","as","isn't","wasn't","weren't","ain't","won't","will","hasn't","haven't","hadn't","did","do","didn't","don't","with"]
		fag_adverbs = ["should","would","could","can","shouldn't","wouldn't","couldn't","can't","cannot",
			"very","really","seriously","totally","highly","extremely","completely","entirely","absolutely",
			"majorly","vastly", "generally","slightly","kinda","sorta","maybe","hopelessly","hopefully","incredibly","currently"]
		pronouns = ["I","you","he","she","they","them","these","those","that","this","her","him","his","their","theirs","your","yours","me","mine"]
		
		combine = modifiers + fag_verbs + fag_adverbs + pronouns
 
		str_vec = string.split(" ")
		mod_str = [ str_vec[0] ]
		return { string => 1 } if string.nil? || str_vec.count == 1
		fagflag = true 
		for k in 1..str_vec.count - 1 do
			if combine.include?( str_vec[k] )
				fagflag = false
				mod_str[mod_str.count-1] += " #{str_vec[k]}"
			else
				if fagflag 
					mod_str.push( str_vec[k] )
				else
					fagflag = true
					mod_str[mod_str.count-1] += " #{str_vec[k]}"
				end
			end
		end
		return mod_str
	end
	
	# Ignogres and chunks
	def self.chunk_ignore_parse( string )	
		chunks = ["isn't","wasn't","weren't","ain't","won't","will","hasn't","haven't","hadn't","did","do","didn't","don't",
			"with","should","would","could","can","shouldn't","wouldn't","couldn't","can't","cannot","to","from"]
		ignores = ["a", "the","of","and","or","either","neither","nor","is","are","am","were","be","has","have","having",
			"had","been","in","as","very","really","seriously","totally","highly","extremely","completely","
			entirely","absolutely","majorly","vastly", "generally","slightly","kinda","sorta","maybe","hopelessly",
			"hopefully","incredibly","currently","I","you","he","she","they","them","these","those","that","this","her",
			"him","his","their","theirs","your","yours","me","mine","my","us","our","ours" ]
			
		str_vec = string.split(" ")
		mod_str = []
		chunkflag = true
		for k in 0..str_vec.count-1 do
			str = str_vec[k]
			unless ignores.include?( str )
				if chunks.include?( str )
					chunkflag = false
					mod_str[mod_str.count-1] += " #{str}" 
				else
					if chunkflag
						mod_str.push( str )
					else
						chunkflag = true
						mod_str[mod_str.count-1] += " #{str}"
					end
				end
			end
		end	
		return mod_str
	end
	
	# Function collapses a str_vec down to an unique hash
	def self.collapse_hash( str_vec )
		str_hash = {}
		str_vec.each do |str|
			str_hash[str] ||= 0
			str_hash[str] += 1
		end
		return str_hash
	end
end
