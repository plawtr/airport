require_relative "weather"
require_relative "nato"

class Airport

  include Weather
  include Nato

  DEFAULT_CAPACITY = 10
  INTRO = "shhhh."
  OUTTRO = "Try again later. OVER. shhh"

  def initialize(options = {})        
    self.capacity = options.fetch(:capacity, capacity)
  end
  
  def planes
    @planes ||= [] 
  end

  def capacity
    @capacity ||= DEFAULT_CAPACITY
  end

  def capacity=(value)
    @capacity = value
  end

  def plane_count
    planes.count        
  end

  def land(plane)
    raise "#{INTRO} #{rand_nato}. You have not asked to land anything. #{OUTTRO}"  if plane.nil?
    raise "#{INTRO} #{rand_nato}. At capacity. There is no more room for planes. #{OUTTRO}" if full?
    raise "#{INTRO} #{rand_nato}. Stormy weather! Not cleared for landing. #{OUTTRO}" if !cleared?
    planes << plane
    plane.land
  end

  def cleared?        
    !stormy?
  end

  def full?
    plane_count >= capacity
  end

  def takeoff(plane)
    raise "#{INTRO} #{rand_nato}. You have not asked to takeoff anything. #{OUTTRO}" if plane.nil?
    raise "#{INTRO} #{rand_nato}. Not available for takeoff at this airport. #{OUTTRO}" unless planes.include?(plane)
    raise "#{INTRO} #{rand_nato}. Stormy weather! Not cleared for takeoff. #{OUTTRO}"  if !cleared?
    planes.delete(plane)
    plane.takeoff
  end
end