module OpenWeatherMap
  # Represents a city
  class City
    # @return [String] City's name
    attr_reader :name

    # @return [Coordinates] City's coordinates
    attr_reader :coordinates

    # @return [String] Country in which the city is
    attr_reader :country

    # Create a new City object
    #
    # @param name [String] City's name
    # @param lon [Float] Longitude of the city
    # @param lat [Float] Latitude of the city
    # @param country [String] Country in which the city is
    def initialize(name, lon, lat, country)
      @name = name
      @coordinates = OpenWeatherMap::Coordinates.new(lon, lat)
      @country = country
    end
  end

  # Represents a location's coordinates
  class Coordinates
    # @return [Float] Longitude of the location
    attr_reader :lon
    
    # @return [Float] Latitude of the location
    attr_reader :lat

    # Create a new Coordinates object
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
    # @return [Time] time of the condition
    attr_reader :time

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

    # @return [Hash] Wind data. Keys : (symbols)
    #   - speed : Wind speed (m/s or miles/hour)
    #   - direction : Wind direction (meteorological degrees)
    attr_reader :wind

    # @return [Float] Clouds percentage
    attr_reader :clouds

    # @return [Hash, nil] Rain volume. Keys : (symbols)
    #   - one_hour : Rain volume for the last 1 hour (mm)
    #   - three_hours : Rain volume for the last 3 hours (mm)
    # Can be nil if there is no rain
    attr_reader :rain

    # @return [Hash, nil] Snow volume. Keys : (symbols)
    #   - one_hour : Snow volume for the last 1 hour (mm)
    #   - three_hours : Snow volume for the last 3 hours (mm)
    # Can be nil if there is no snow
    attr_reader :snow

    # Create a new WeatherConditions object.
    #
    # @param data [Hash] all the received data
    def initialize(data)
      @time = Time.at(data['dt'])
      @main = data['weather'][0]['main']
      @description = data['weather'][0]['description']
      @icon = "https://openweathermap.org/img/w/#{data['weather'][0]['icon']}.png"
      @emoji = OpenWeatherMap::Constants::CONDITION_CODE[data['weather'][0]['icon'].sub('n', 'd')]
      @temperature = data['main']['temp']
      @temp_min = data['main']['temp_min'].to_f
      @temp_max = data['main']['temp_max'].to_f
      @pressure = data['main']['pressure'].to_f
      @humidity = data['main']['humidity'].to_f
      @wind = {
        speed: data['wind']['speed'],
        direction: data['wind']['deg']
      }
      @clouds = data['clouds']['all'].to_f
      @rain = data['rain'].nil? ? nil : {
        one_hour: data['rain']['1h'],
        three_hours: data['rain']['3h']
      }
      @snow = data['snow'].nil? ? nil : {
        one_hour: data['snow']['1h'],
        three_hours: data['snow']['3h']
      }
    end
  end
end