# frozen_string_literal: true

require 'net/http'
require 'json'

require 'openweathermap/classes'
require 'openweathermap/current-weather'
require 'openweathermap/forecast'
require 'openweathermap/api'

module OpenWeatherMap
  module Constants
    # URL of the OpenWeatherMap API
    API_URL = 'https://api.openweathermap.org'

    # Accepted types of unit
    UNITS = %w(default metric imperial)

    # Accepted locales
    LANGS = %w(ar bg ca cz de el fa fi fr gl hr hu it ja kr la lt mk nl pl pt ro ru se sk sl es tr ua vi zh_cn zh_tw en)

    # The different URLs
    URLS = {
      current: '/data/2.5/weather',
      forecast: '/data/2.5/forecast'
    }

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
  end

  class Exception < StandardError
  end

  module Exceptions
    # Exception to handle unknown lang
    class UnknownLang < Exception
    end

    # Exception to handle unknown units
    class UnknownUnits < Exception
    end

    # Exception to handle unknown location
    class UnknownLocation < Exception
    end

    # Exception to tell that the API key isn't authorized
    class Unauthorized < Exception
    end
  end
end
