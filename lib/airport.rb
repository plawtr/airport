require_relative "weather"

class Airport

  include Weather

  DEFAULT_CAPACITY = 10

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
    raise "GOLF-OSCAR BRAVO. You have not asked to land anything. OVER" if plane.nil?
    raise "shhhh. GOLF-OSCAR BRAVO. At capacity. There is no more room for planes. Try again later. OVER." if full?
    raise "shhhh. GOLF-OSCAR BRAVO. Stormy weather. Not cleared for landing. Try again later. OVER." if !cleared?
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
    raise "GOLF-OSCAR BRAVO. You have not asked to takeoff anything." if plane.nil?
    raise "shhhh. GOLF-OSCAR BRAVO. Not available for takeoff at this airport. Try again later. OVER." unless planes.include?(plane)
    raise "shhhh. GOLF-OSCAR BRAVO. Stormy weather. Not cleared for takeoff. Try again later. OVER." if !cleared?
    planes.delete(plane)
    plane.takeoff
  end
end