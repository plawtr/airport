module Nato

CHARS = {:a=>"alfa", :b=>"bravo", :c=>"charlie", :d=>"delta", :e=>"echo", :f=>"foxtrot", :g=>"golf", :h=>"hotel", :i=>"india", :j=>"juliett", :k=>"kilo", :l=>"lima", :m=>"mike", :n=>"november", :o=>"oscar", :p=>"papa", :q=>"quebec", :r=>"romeo", :s=>"sierra", :t=>"tango", :u=>"uniform", :v=>"victor", :w=>"whiskey", :x=>"x-ray", :y=>"yankee", :z=>"zulu"} 

	def rand_nato	
		('a'..'z').to_a.shuffle[0,3].map {|char| CHARS[char.to_sym] }.join(" ")
	end

end


