class LocationCoordinatesActionType
  # An enum for LocationCoordinates
  
  def self.VISIT
    return {
      index: 0,
      canonical_name: 'visit',
      display_name: 'Visit'
    }
  end
  
  def self.TRAVEL
    return {
      index: 1,
      canonical_name: 'travel',
      display_name: 'En Route'
    }
  end
  
  def self.from_index(index)
    [self.VISIT, self.TRAVEL].each do |action|
      return action if action[:index] == index
    end
    nil  # each returns the array I guess?
  end
end
