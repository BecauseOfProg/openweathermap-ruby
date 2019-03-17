module OpenWeatherMap
  module Constants
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
end