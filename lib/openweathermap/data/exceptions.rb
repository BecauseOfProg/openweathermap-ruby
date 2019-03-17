module OpenWeatherMap
  module Exceptions
    # Exception to handle unknown lang
    class UnknownLang < StandardError
    end

    # Exception to handle unknown units
    class UnknownUnits < StandardError
    end
  end
end