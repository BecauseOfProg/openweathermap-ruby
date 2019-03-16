# Represents the current weather at a location
class CurrentWeather
  # @return [Coordinates] Coordinates of the location
  attr_reader :coordinates
  
  # @return [WeatherConditions] Conditions at the moment
  attr_reader :weather_conditions

  # @return [String] Requested city
  attr_reader :city

  # @return [String] Location's country code
  attr_reader :country
  
  # Create a new CurrentWeather object
  #
  # @param data [Hash] mixed data from the request
  def initialize(data)
    data = JSON.parse(data)
    @city = data['name']
    @country = data['sys']['country']
    @coordinates = Coordinates.new(data['coord']['lon'], data['coord']['lat'])
    @weather_conditions = WeatherConditions.new(data)
  end
end