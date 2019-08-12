<div align="center">
  <img src="https://openweathermap.org/themes/openweathermap/assets/vendor/owm/img/logo_OpenWeatherMap_orange.svg" height="50"/>
  <h1>OpenWeatherMap - The Ruby implementation</h1>
  <p>With this gem, you can easily fetch the API to receive informations about weather.</p>
  <a href="LICENSE">License</a> - <a href="http://rubydoc.info/gems/openweathermap">RubyDoc</a>
</div>

## Why would I use this library ?

Before writing this OpenWeatherMap implementation, I checked for existing ones on rubygems.org. There's only small libraries, that has at least one or two good thing but that's all. Consequently, I decided to make my own one, combining all their advantages :

- **Centralized :** all the options and fetch methods are stored in one class, that is initialized only once in all the program. Parameters are the same across all requests.
- **Fast :** the only thing that can slow the library is your Internet connection : indeed, no heavy operations are made in the background. As soon as it receives weather conditions, the only step for it is organizing them.
- **Simple :** the library only contains essential operations to keep the number of methods low. Moreover, all the information is perfectly human-readable.
- **Documented :** every method and class attribute is explained and every exception thrown is explicit, therefore learning or debugging the library remains easy.

This work resulted in a powerful implementation that responds to primary needs while staying abordable.

- [📌 Requirements](#-requirements)
- [🔧 Setup](#-setup)
  - [Quick installation](#quick-installation)
  - [Gemfile](#gemfile)
  - [Build](#build)
- [⌨ Basic interactions](#-basic-interactions)
  - [Setup the API](#setup-the-api)
  - [Get current weather](#get-current-weather)
  - [Get forecast](#get-forecast)
  - [Possible exceptions](#possible-exceptions)
- [📜 Credits](#-credits)
- [🔐 License](#-license)

## 📌 Requirements

This library requires an updated version of Ruby.

## 🔧 Setup

### Quick installation

If you want to quickly test the library, you can install it using the `install` command of Ruby Gem.

```bash
gem install openweathermap
```

### Gemfile

If you setup the library for medium or big projects, it's recommended to write it in your Gemfile.

```gemfile
gem 'openweathermap', '~> 0.2.2'
```

After, use again the `install` command, but without the package name.

```bash
gem install
```

### Build

You can also compile it by yourself. First, clone the repository.

```bash
git clone https://github.com/BecauseOfProg/openweathermap-ruby.git  # HTTP
          git@github.com:BecauseOfProg/openweathermap-ruby.git      # SSH
```

Then, build the gemspec file to create the gem.

```bash
gem build ./openweathermap.gemspec
```

Finally, install it on your system.

```bash
gem install ./openweathermap-0.2.2.gem
```

## ⌨ Basic interactions

Once you finished installing the library, you're ready to play around.

### Setup the API

First of all, include the `openweathermap` library in your project :

```ruby
include 'openweathermap'
```

Then, we must initialize an `API` object in the `OpenWeatherMap` module, that we'll use to get our weather data.

```ruby
api = OpenWeatherMap::API.new(API_KEY, 'en', 'metric')
```

The constructor takes three parameters :

- The first is an API key, that can be generated on the [OpenWeatherMap website](https://openweathermap.org/appid)
- The second is the language of the data. It can be one of these : Arabic - ar, Bulgarian - bg, Catalan - ca, Czech - cz, German - de, Greek - el, English - en, Persian (Farsi) - fa, Finnish - fi, French - fr, Galician - gl, Croatian - hr, Hungarian - hu, Italian - it, Japanese - ja, Korean - kr, Latvian - la, Lithuanian - lt, Macedonian - mk, Dutch - nl, Polish - pl, Portuguese - pt, Romanian - ro, Russian - ru, Swedish - se, Slovak - sk, Slovenian - sl, Spanish - es, Turkish - tr, Ukrainian - ua, Vietnamese - vi, Chinese Simplified - zh_cn, Chinese Traditional - zh_tw.
- The third is the unit system. It can be one of these :
  - none (temperatures in Kelvin)
  - metric (temperatures in Celsius)
  - imperial (temperatures in Fahrenheit)

### Get current weather

To get the current weather at a certain city anywhere in the world, use the `current` method of the API object :

```ruby
api.current('Lyon,FR')
```

It only takes one parameter : the location. It can be one of this type :

- A simple string : search by city name. To have more precision, it can be completed with the country code separated by a comma
- An integer : search by city ID (refer to [OpenWeatherMap](http://bulk.openweathermap.org/sample/city.list.json.gz))
- An array : search by coordinates (format : [longitude, latitude])

The method will return a `OpenWeatherMap::CurrentWeather` object that you can explore [on RubyDoc](http://rubydoc.info/gems/openweathermap/0.2.2/OpenWeatherMap/CurrentWeather).

### Get forecast

To get the forecast for a certain city anywhere in the world, use the `forecast` method of the API object :

```ruby
api.forecast('Paris,FR')
```

Its parameter is the same as the `current` method. It will return a `OpenWeatherMap::Forecast` object that you can explore [on RubyDoc](http://rubydoc.info/gems/openweathermap/0.2.2/OpenWeatherMap/Forecast).

### Possible exceptions

Your requests may return exceptions that are in the `OpenWeatherMap::Exceptions` module :

- An `Unauthorized` exception, caused when your API key is wrong
- An `UnknownLocation` exception, caused if the location you wrote is wrong

These exceptions will have in their body the message sent by the OpenWeatherMap API, so you can easily debug them.

## 📜 Credits

- Used service : [OpenWeatherMap](https://openweathermap.org)
- Maintainer : [Exybore](https://github.com/exybore)

## 🔐 License

MIT License

Copyright (c) 2019 BecauseOfProg

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
