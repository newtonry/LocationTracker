require './models/action'


RSpec.describe Action, "Action model" do
  context "If there are no location coordinates" do
    location_coordinates = []
    
    it "should return no actions" do
      actions = Action.from_location_coordinates(location_coordinates)
      expect(actions.length).to eq 0
    end
  end
end