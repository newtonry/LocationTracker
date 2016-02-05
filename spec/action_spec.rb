load './models/action.rb'  # TODO look into this more, I need to load b/c if I require in a different file, this craps out?
require './models/location_coordinates'
require './tasks/one_offs/wipe_all_the_tables'

RSpec.describe Action, "Action model" do

  describe "from_location_coordinates" do


    context "If it's the last known location" do
      location = LocationCoordinates.create(user_id: 1, time_visited: DateTime.now, lat: 10, lng: 20)
      actions = Action.from_location_coordinates([location])

      it "should be considered a visit" do
        expect(actions.length).to eq 1
        actions.first.location_coordinates.should include(location)
      end

      it "should have a user id" do
        expect(actions.first.user_id).to be(1)
      end
    end

    context "If there are no location coordinates" do
      location_coordinates = []
      it "should return no actions" do
        actions = Action.from_location_coordinates(location_coordinates)
        expect(actions.length).to eq 0
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
    # RECONSIDER THE TESTS ABOVE


    context "If location coordinates seem to be moving around a lot and then stop for 15+ minutes" do

      original_datetime = DateTime.now
      travelling_location_coordinates = []
      # Moving around a lot
      travelling_location_coordinates << LocationCoordinates.new(user_id: 1, time_visited: original_datetime, lat: 10, lng: 20)
      travelling_location_coordinates << LocationCoordinates.new(user_id: 1, time_visited: (original_datetime + 5.minutes), lat: 12, lng: 20)
      travelling_location_coordinates << LocationCoordinates.new(user_id: 1, time_visited: (original_datetime + 10.minutes), lat: 14, lng: 20)
      # Stationary ones
      visiting_location_coordinates = []
      visiting_location_coordinates << LocationCoordinates.new(user_id: 1, time_visited: (original_datetime + 15.minutes), lat: 16.00000001, lng: 20)
      visiting_location_coordinates << LocationCoordinates.new(user_id: 1, time_visited: (original_datetime + 20.minutes), lat: 16.000000012, lng: 20)
      visiting_location_coordinates << LocationCoordinates.new(user_id: 1, time_visited: (original_datetime + 25.minutes), lat: 16.000000013, lng: 20)
      visiting_location_coordinates << LocationCoordinates.new(user_id: 1, time_visited: (original_datetime + 30.minutes), lat: 16.000000014, lng: 20)      

      location_coordinates = travelling_location_coordinates + visiting_location_coordinates
      actions = Action.from_location_coordinates(location_coordinates)

      it "should have 2 actions" do
        expect(actions.length).to eq 2
      end

      it "should have the first action of TRAVEL type including all the moving location coordinates" do
        expect(actions[0].type).to eq LocationCoordinatesActionType.TRAVEL
        travelling_location_coordinates.each do |location|
          expect(actions[0].location_coordinates).to include location
        end
      end

      it "should have the second action as a VISIT including all the stationary location coordinates" do
        expect(actions[1].type).to eq LocationCoordinatesActionType.VISIT
        visiting_location_coordinates.each do |location|
          expect(actions[1].location_coordinates).to include location
        end

      end

      it "should have a VISIT with an average point in the middle of all location points" do
      end
    end
  end

  # context "If it's the last known location for a long time" do
  # end
  #
  #
  
end