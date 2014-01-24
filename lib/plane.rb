

class Plane

	def initialize
		 @flying = true
	end

	def flying?
		@flying
	end

	def takeoff
		@flying = true
	end

	def land
	 	@flying = false
	end

	def landed?
		!flying?
	end




end

