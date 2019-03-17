# Represents the forecast for a specific location
class Forecast
  # @return [City] Requested city's data
  attr_reader :city

  # @return [Array<WeatherConditions>] Forecast for many days and hours
  attr_reader :forecast

  # Create a new Forecast object
  #
  # @param data [Hash] mixed data from the request
  def initialize(data)
    data = JSON.parse(data)
    @city = City.new(data['city']['name'], data['city']['coord']['lon'], data['city']['coord']['lat'], data['city']['country'])
    @forecast = []
    data['list'].each do |element|
      forecast << WeatherConditions.new(element)
    end
  end
end