# Weather Forecast

## Set Up

### Install Ruby version manager ASDF

Install using Homebrew:

```
$ brew install asdf
$ echo -e "\n. \"$(brew --prefix asdf)/libexec/asdf.sh\"" >> ~/.bash_profile
$ echo -e "\n. \"$(brew --prefix asdf)/etc/bash_completion.d/asdf.bash\"" >> ~/.bash_profile
$ source ~/.bash_profile
```

## Install Ruby
```
$ asdf plugin add ruby
$ asdf install ruby latest
```

## Install Rails
```
$ gem install rails
```

## Install PostgreSQL
```
$ brew install postgresql@14
```

## Install Weather Forecast App
```
$ git clone https://github.com/pwenig/weather-app.git
$ cd weather
$ bundle install
$ rake db:create
$ rails s
```

### Add OpenWeather API Key
```
$ EDITOR=nano rails credentials:edit
openweather_api_key: <your-key>
```

### Add Google Maps API Key
To get a key: https://developers.google.com/maps/documentation/geocoding/get-api-key#creating-api-keys

```
$ EDITOR=nano rails credentials:edit
geocoder_api_key: <your-key>
```

## Developer Notes
To run tests (RSpec):
```
$ bundle exec rspec
```
