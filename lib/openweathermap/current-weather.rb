# frozen_string_literal: true

module OpenWeatherMap

  ##
  # Represents the current weather at a location

  class CurrentWeather

    ##
    # @return [OpenWeatherMap::WeatherConditions] Conditions at the moment

    attr_reader :weather_conditions

    ##
    # @return [OpenWeatherMap::City] Requested city's data

    attr_reader :city

    ##
    # Create a new CurrentWeather object
    #
    # @param data [Hash] mixed data from the request

    def initialize(data)
      begin
        data = JSON.parse(data)
      rescue JSON::JSONError => e
        raise OpenWeatherMap::Exceptions::DataError, "error while parsing data : #{e}"
      end
      @city = OpenWeatherMap::City.new(data['name'], data['coord']['lon'], data['coord']['lat'], data['sys']['country'])
      @weather_conditions = OpenWeatherMap::WeatherConditions.new(data)
    end
  end
end