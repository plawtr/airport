require_relative "../lib/plane"

describe Plane do 

	let(:plane) {Plane.new}

	it "should be flying after we create it" do

		expect(plane).to be_flying

	end

	it "can take off" do
		plane.takeoff
		expect(plane).to be_flying 
	end

	it "can land" do
		plane.land
		expect(plane).not_to be_flying 
	end

	it "can tell if it is landed" do
		plane.land
		expect(plane.landed?).to be_true
	end


end
