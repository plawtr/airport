require_relative "../lib/airport"

describe Airport do 

	let(:airport) {Airport.new}
	let(:plane)   {Plane.new}
	let(:heathrow) {Airport.new(capacity: 1000)}
	let(:ba101)   {Plane.new}
	let(:smallton) {Airport.new(capacity: 1)}

it "should initialize with a default value of landing spots (10)" do
	expect(airport.capacity).to eq(10)
end

it "should initialize with an overriden capacity value" do
	expect(heathrow.capacity).to eq(1000)
end

it "should provide an intial plane count of 0" do
	expect(heathrow.plane_count).to eq(0)
end

it "should be able to land a plane" do
	expect(ba101.flying?).to be_true
	heathrow.stub(:stormy?){false}
	heathrow.land(ba101)
	expect(heathrow.plane_count).to eq(1)
end

it "should not land a plane if asked to land nothing" do
  airport.stub(:stormy?){false}
  expect{airport.land(nil)}.to raise_error(RuntimeError)
end

it "should know when it is full" do
	expect(ba101.flying?).to be_true
	smallton.stub(:stormy?){false}
	smallton.land(ba101)
	expect(smallton.plane_count).to eq(1)
	expect(smallton.full?).to be_true
end

it "should not land a plane when full" do
	smallton.stub(:stormy?){false}
	smallton.land(plane)
  expect{smallton.land(ba101)}.to raise_error(RuntimeError)
end

it "should be able to clear a plane for takeoff or landing" do 
	heathrow.stub(:stormy?){false}
	expect(heathrow.cleared?).to be_true
end

it "should be able to land a plane" do 
	heathrow.stub(:stormy?){false}
	heathrow.land(ba101)
	expect(ba101).not_to be_flying
	expect(ba101).to be_landed
end


it "should be able to takeoff a plane" do 
	heathrow.stub(:stormy?){false}
	heathrow.land(ba101)
	expect(ba101).not_to be_flying
	expect(ba101).to be_landed
	expect(heathrow.plane_count).to eq(1)
	
	expect{heathrow.takeoff(nil)}.to raise_error(RuntimeError)
	expect{heathrow.takeoff(plane)}.to raise_error(RuntimeError)
	
	heathrow.stub(:stormy?){true}
	expect{heathrow.takeoff(ba101)}.to raise_error(RuntimeError)
	
	heathrow.stub(:stormy?){false}
	heathrow.takeoff(ba101)
	expect(heathrow.plane_count).to eq(0)
	expect(ba101).to be_flying 
end


it "should be able to handle 6 planes in 6 capacity airport in always good weather" do 
	gatwick = Airport.new(capacity: 6)
	gatwick.stub(:stormy?){false}
	test_planes = Array.new(6){Plane.new}
	test_planes.each{|plane| gatwick.land(plane)}
	expect(gatwick).to be_full
	test_planes.each{|plane| expect(plane).to be_landed}
	expect{gatwick.land(ba101)}.to raise_error(RuntimeError)
	expect(gatwick.plane_count).to eq(6)
	expect{gatwick.takeoff(plane)}.to raise_error(RuntimeError)
	test_planes.each{|plane| gatwick.takeoff(plane)}
	expect(gatwick.plane_count).to eq(0)
	test_planes.each{|plane| expect(plane).to be_flying}
end

it "should be able to handle 6 circling planes in 6 capacity airport in changing weather" do 
	gatwick = Airport.new(capacity: 6)
	test_planes = Array.new(6){Plane.new}
	
	test_planes.each do |plane| 
		while plane.flying? do 
			begin
				gatwick.land(plane) 
			rescue => e
			 `say -v Albert #{e.message.to_s}`
				#puts e.message
			end
		end
		expect(plane).to be_landed
	end

	expect(gatwick.plane_count).to eq(6)

	test_planes.each do |plane| 
		while plane.landed? do 
			begin 
				gatwick.takeoff(plane)
			rescue => e
				`say -v Albert #{e.message.to_s}`
				#puts e.message
			end
		end
		expect(plane).to be_flying
	end

	expect(gatwick.plane_count).to eq(0)
	test_planes.each{|plane| expect(plane).to be_flying}
end

end
