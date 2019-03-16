# All condition codes associated with emojis
CONDITION_CODE = {
  '01d' => '☀',
  '02d' => '⛅',
  '03d' => '☁',
  '04d' => '☁☁',
  '09d' => '🌧',
  '10d' => '🌦',
  '11d' => '🌩',
  '13d' => '🌨',
  '50d' => '🌫',
}

class Coordinates
  # @return [Float] Longitude of the location
  attr_reader :lon
  
  # @return [Float] Latitude of the location
  attr_reader :lat

  # Create a new Coordinates object
  #
  #
  # @param lon [Float] Longitude of the location
  # @param lat [Float] Latitude of the location
  def initialize(lon, lat)
    @lon = lon
    @lat = lat
  end
end

# Represents the weather conditions
class WeatherConditions
  # @return [String] Main weather contitions at the moment
  attr_reader :main

  # @return [String] Details of weather conditions
  attr_reader :description

  # @return [String] URL to conditions icon illustration
  attr_reader :icon

  # @return [String] Conditions illustrated by an emoji
  attr_reader :emoji

  # @return [Float] Temperature
  attr_reader :temperature

  # @return [Float] Minimum temperature at the moment (for large areas)
  attr_reader :temp_min

  # @return [Float] Maximum temperature at the moment (for large areas)
  attr_reader :temp_max

  # @return [Float] Atmospheric pressure in hPa
  attr_reader :pressure

  # @return [Float] Humidity percentage
  attr_reader :humidity

  # Create a new WeatherConditions object.
  #
  # @param data [Hash] all the received data
  def initialize(data)
    @main = data['weather'][0]['main']
    @description = data['weather'][0]['description']
    @icon = "https://openweathermap.org/img/w/#{data['weather'][0]['icon']}.png"
    @emoji = CONDITION_CODE[data['weather'][0]['icon'].sub('n', 'd')]
    @temperature = data['main']['temp']
    @temp_min = data['main']['temp_min']
    @temp_max = data['main']['temp_max']
    @pressure = data['main']['pressure']
    @humidity = data['main']['humidity']
  end
end