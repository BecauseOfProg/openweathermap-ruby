require 'net/http'
require 'json'

require_relative 'classes'
require_relative 'current-weather'
require_relative 'forecast'

# URL of the OpenWeatherMap API
API_URL = 'https://api.openweathermap.org'

# Accepted types of unit
UNITS = ['metric', 'imperial']

# Accepted locales
LANGS = ['fr', 'en']

# The different URLs 
URLS = {
  current: '/data/2.5/weather',
  forecast: '/data/2.5/forecast'
}

# Exception to handle unknown lang
class UnknownLang < StandardError
end

# Exception to handle unknown units
class UnknownUnits < StandardError
end

# The main API class.
class WeatherAPI
  # @return [String] Default lang to use
  attr_accessor :lang
  
  # @return [String] Default units to use
  attr_accessor :units

  # Initialize the API object
  #
  # @param api_key [String] your OpenWeatherMap's API key
  #   For further information, go to https://openweathermap.org/price
  # @param lang [String] the default lang
  #   Accepted values : 
  # @param units [String] the units system to use
  #   Accepted values : 
  #   - none (temperatures in Kelvin)
  #   - metric (temperatures in Celsius)
  #   - imperial (temperatures in Fahrenheit)
  def initialize(api_key, lang = 'en', units = nil)
    @api_key = api_key

    raise UnknownLang, "[owm-ruby] error : unknown lang #{lang}" unless LANGS.include? lang
    @lang = lang

    raise UnknownUnits, "[owm-ruby] error : unknown units #{units}" unless UNITS.include? units
    @units = units
  end

  # Get current weather at a specific location.
  #
  # @param location [String, Integer, Array] the location
  #   Can be one of this type :
  #   - String : search by city name
  #   - Integer : search by city ID (refer to bulk.openweathermap.org/sample/city.list.json.gz)
  #   - Array : search by coordinates (format : [lon, lat])
  # @return [CurrentWeather] requested data
  def current(location)
    data = make_request(URLS[:current], location)
    CurrentWeather.new(data)
  end

  # Get weather forecast for a specific location.
  #
  # @param location [String, Integer, Array] the location
  #   Can be one of this type :
  #   - String : search by city name
  #   - Integer : search by city ID (refer to bulk.openweathermap.org/sample/city.list.json.gz)
  #   - Array : search by coordinates (format : [lon, lat])
  # @return [CurrentWeather] requested data
  def forecast(location)
    data = make_request(URLS[:forecast], location)
    Forecast.new(data)
  end

  private

  # Make a request to the OpenWeatherMap API.
  #
  # @param url [String] The endpoint to reach
  # @param options [Hash] mixed options
  # @return [String] request's body
  def make_request(url, location)
    options = {}
    options[:q] = location if location.is_a? String
    options[:id] = location if location.is_a? Integer
    if location.is_a? Array
      options[:lon] = location[0]
      options[:lat] = location[1]
    end

    params = {
      apikey: @api_key,
      lang: @lang,
      units: @units
    }
    params.merge! options

    url = "#{API_URL}/#{url}?"

    params.each do |key, value|
      url += "#{key}=#{value}&"
    end

    response = Net::HTTP.get_response(URI(url))
    response.body
  end
end