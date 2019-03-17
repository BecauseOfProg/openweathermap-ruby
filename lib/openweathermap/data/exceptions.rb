module OpenWeatherMap
  module Exceptions
    # Exception to handle unknown lang
    class UnknownLang < StandardError
    end

    # Exception to handle unknown units
    class UnknownUnits < StandardError
    end

    # Exception to handle unknown location
    class UnknownLocation < StandardError
    end

    # Exception to tell that the API key isn't authorized
    class Unauthorized < StandardError
    end
  end
end