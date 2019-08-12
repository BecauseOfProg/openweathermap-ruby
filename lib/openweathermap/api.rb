# frozen_string_literal: true

module OpenWeatherMap
  # The main API class.
  class API
    # @return [String] Default lang to use
    attr_reader :lang
    
    # @return [String] Default units to use
    attr_reader :units

    # Initialize the API object
    #
    # @param api_key [String] your OpenWeatherMap's API key
    #   For further information, go to https://openweathermap.org/price
    # @param lang [String] the default lang
    #   Refer to OpenWeatherMap::Constants::LANGS for accepted values
    # @param units [String] the units system to use
    #   Accepted values : 
    #   - none (temperatures in Kelvin)
    #   - metric (temperatures in Celsius)
    #   - imperial (temperatures in Fahrenheit)
    # @raise [OpenWeatherMap::Exceptions::UnknownLang] if the selected lang is not unknown
    # @raise [OpenWeatherMap::Exceptions::UnknownUnits] if the selected units is not unknown
    def initialize(api_key, lang = 'en', units = 'default')
      @api_key = api_key

      raise OpenWeatherMap::Exceptions::UnknownLang, "unknown lang #{lang}" unless OpenWeatherMap::Constants::LANGS.include? lang
      @lang = lang

      raise OpenWeatherMap::Exceptions::UnknownUnits, "unknown units #{units}" unless OpenWeatherMap::Constants::UNITS.include? units
      @units = units
    end

    # Get current weather at a specific location.
    #
    # @param location [String, Integer, Array] the location
    #   Can be one of this type :
    #   - String : search by city name
    #   - Integer : search by city ID (refer to http://bulk.openweathermap.org/sample/city.list.json.gz)
    #   - Array : search by coordinates (format : [lon, lat])
    # @return [OpenWeatherMap::CurrentWeather] requested data
    def current(location)
      data = make_request(OpenWeatherMap::Constants::URLS[:current], location)
      OpenWeatherMap::CurrentWeather.new(data)
    end

    # Get weather forecast for a specific location.
    #
    # @param location [String, Integer, Array] the location
    #   Can be one of this type :
    #   - String : search by city name
    #   - Integer : search by city ID (refer to bulk.openweathermap.org/sample/city.list.json.gz)
    #   - Array : search by coordinates (format : [lon, lat])
    # @return [OpenWeatherMap::Forecast] requested data
    def forecast(location)
      data = make_request(OpenWeatherMap::Constants::URLS[:forecast], location)
      OpenWeatherMap::Forecast.new(data)
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

      url = "#{OpenWeatherMap::Constants::API_URL}/#{url}?#{URI.encode_www_form(params)}"

      response = Net::HTTP.get_response(URI(url))
      case response.code.to_i
      when 401 then raise OpenWeatherMap::Exceptions::Unauthorized, "unauthorized key. API message : #{response.message}"
      when 404 then raise OpenWeatherMap::Exceptions::UnknownLocation, "unknown location. API message : #{location}"
      else response.body
      end
    end
  end
end