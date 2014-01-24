require_relative "../lib/plane"

describe Plane do 

	let(:plane) {Plane.new}

	it "should be flying after we create it" do

		expect(plane).to be_flying

	end


end
