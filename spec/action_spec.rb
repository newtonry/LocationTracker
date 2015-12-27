require './models/action'
require './models/location_coordinates'


# TODO get this to use a fake DB


RSpec.describe Action, "Action model" do
  context "If there are no location coordinates" do
    location_coordinates = []
    
    it "should return no actions" do
      actions = Action.from_location_coordinates(location_coordinates)
      expect(actions.length).to eq 0
    end
  end

  context "If it's the last known location" do
    location = LocationCoordinates.create
    
    it "should be considered a visit" do 
      actions = Action.from_location_coordinates([location])
      expect(actions.length).to eq 1
      actions.first.location_coordinates.should include(location)
    end
  end

  context "If there's a bunch of distant coordinates within a time range" do
    it "should not consider any except for the last location a visit action" do
    end
  end

  context "If there's a bunch of distant coordinates within a time range" do
    it "should not consider any except for the last coordinate a visit action" do
    end
  end




  # context "If it's the last known location for a long time" do
  # end
  #
  #
  
end