# frozen_string_literal: true

module OpenWeatherMap

  ##
  # Represents the forecast for a specific location

  class Forecast

    ##
    # @return [OpenWeatherMap::City] Requested city's data

    attr_reader :city

    ##
    # @return [Array<OpenWeatherMap::WeatherConditions>] Forecast for many days and hours

    attr_reader :forecast

    ##
    # Create a new Forecast object
    #
    # @param data [Hash] mixed data from the request

    def initialize(data)
      data = JSON.parse(data)
      @city = OpenWeatherMap::City.new(data['city']['name'], data['city']['coord']['lon'], data['city']['coord']['lat'], data['city']['country'])
      @forecast = []
      data['list'].each do |element|
        forecast << OpenWeatherMap::WeatherConditions.new(element)
      end
    end
  end
end