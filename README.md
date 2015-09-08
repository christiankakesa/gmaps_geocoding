# GmapsGeocoding [![Gem Version](https://badge.fury.io/rb/gmaps_geocoding.svg)](http://badge.fury.io/rb/gmaps_geocoding) [![Build Status](https://travis-ci.org/fenicks/gmaps_geocoding.svg?branch=master)](https://travis-ci.org/fenicks/gmaps_geocoding) [![Coverage Status](https://coveralls.io/repos/fenicks/gmaps_geocoding/badge.svg?branch=master&service=github)](https://coveralls.io/github/fenicks/gmaps_geocoding?branch=master)

A simple Ruby gem for Google Maps Geocoding API.
This gem return a Ruby Hash object of the result.

## Installation

Add this line to your application's Gemfile:

    gem 'gmaps_geocoding'

And then execute:

    bundle

Or install it yourself as:

    gem install gmaps_geocoding

## Usage
### Global information

See [Google Maps Geocoding service documentation](https://developers.google.com/maps/documentation/geocoding/) for options parameters and *result* handling.

All options could be overriden with corresponding environment variable:

* `GOOGLE_MAPS_GEOCODING_URL`: HTTP endpoint to the Google geocoding service by default is set to [https://maps.googleapis.com/maps/api/geocode](https://maps.googleapis.com/maps/api/geocode).
* `GOOGLE_MAPS_GEOCODING_OUTPUT`: By default is set to `json`
* `GOOGLE_MAPS_GEOCODING_KEY`
* `GOOGLE_MAPS_GEOCODING_ADDRESS`
* `GOOGLE_MAPS_GEOCODING_LATLNG`
* `GOOGLE_MAPS_GEOCODING_COMPONENTS`
* `GOOGLE_MAPS_GEOCODING_SENSOR`: By default is set to `false`
* `GOOGLE_MAPS_GEOCODING_BOUNDS`
* `GOOGLE_MAPS_GEOCODING_LANGUAGE`
* `GOOGLE_MAPS_GEOCODING_REGION`
* `GOOGLE_MAPS_GEOCODING_PLACE_ID`
* `GOOGLE_MAPS_GEOCODING_RESULT_TYPE`
* `GOOGLE_MAPS_GEOCODING_LOCATION_TYPE`

### Easy way to use for both JSON and XML format

    opts = {address: 'Tour Eiffel, Paris, IDF, France'}
    api = GmapsGeocoding::Api.new(opts)
    data = api.location
    loc = api.finest_latlng(data['results']) if data.include?('status') && data['status'].eql?('OK')

_Return a location array_

* `loc[0] is the longitude float value`
* `loc[1] is the latitude float value`

`finest_latlng` retrieve the best address in this order:

* _ROOFTOP_
* _RANGE_INTERPOLATED_
* _GEOMETRIC_CENTER_
* _APPROXIMATE_

### JSON example

    # json output example
    opts = {address: 'Tour Eiffel, Paris, IDF, France', output: 'json'}
    api = GmapsGeocoding::Api.new(opts)
    result = api.location

### XML example

    # xml output example
    opts = {address: 'Tour Eiffel, Paris, IDF, France', output: 'xml'}
    api = GmapsGeocoding::Api.new(opts)
    result = api.location

# JSON and XML output

**Ruby Hash object from json output**

```ruby
{
  "results"=>[{
    "address_components"=>[
      {"long_name"=>"Eiffel Tower", "short_name"=>"Eiffel Tower", "types"=>["point_of_interest", "establishment"]},
      {"long_name"=>"5", "short_name"=>"5", "types"=>["street_number"]},
      {"long_name"=>"Avenue Anatole France", "short_name"=>"Avenue Anatole France", "types"=>["route"]},
      {"long_name"=>"Paris", "short_name"=>"Paris", "types"=>["locality", "political"]},
      {"long_name"=>"Paris", "short_name"=>"75", "types"=>["administrative_area_level_2", "political"]},
      {"long_name"=>"Île-de-France", "short_name"=>"IDF", "types"=>["administrative_area_level_1", "political"]},
      {"long_name"=>"France", "short_name"=>"FR", "types"=>["country", "political"]},
      {"long_name"=>"75007", "short_name"=>"75007", "types"=>["postal_code"]}
    ],
    "formatted_address"=>"Eiffel Tower, Champ de Mars, 5 Avenue Anatole France, 75007 Paris, France",
    "geometry"=>{
      "location"=>{"lat"=>48.85837009999999, "lng"=>2.2944813},
      "location_type"=>"APPROXIMATE", 
      "viewport"=>{
        "northeast"=>{"lat"=>48.8597190802915, "lng"=>2.295830280291502}, 
        "southwest"=>{"lat"=>48.8570211197085, "lng"=>2.293132319708498}
      }
    },
    "place_id"=>"ChIJLU7jZClu5kcR4PcOOO6p3I0",
    "types"=>["premise", "point_of_interest", "establishment"]
  }],
  "status"=>"OK"
}
```

**Ruby Hash object from xml output**

```ruby
{
  "status"=>"OK", 
  "result"=>{
    "type"=>["premise", "point_of_interest", "establishment"],
    "formatted_address"=>"Eiffel Tower, Champ de Mars, 5 Avenue Anatole France, 75007 Paris, France",
    "address_component"=>[
      {"long_name"=>"Eiffel Tower", "short_name"=>"Eiffel Tower", "type"=>["point_of_interest", "establishment"]},
      {"long_name"=>"5", "short_name"=>"5", "type"=>"street_number"},
      {"long_name"=>"Avenue Anatole France", "short_name"=>"Avenue Anatole France", "type"=>"route"},
      {"long_name"=>"Paris", "short_name"=>"Paris", "type"=>["locality", "political"]},
      {"long_name"=>"Paris", "short_name"=>"75", "type"=>["administrative_area_level_2", "political"]},
      {"long_name"=>"Île-de-France", "short_name"=>"IDF", "type"=>["administrative_area_level_1", "political"]},
      {"long_name"=>"France", "short_name"=>"FR", "type"=>["country", "political"]},
      {"long_name"=>"75007", "short_name"=>"75007", "type"=>"postal_code"}
    ],
    "geometry"=>{
      "location"=>{"lat"=>"48.8583701", "lng"=>"2.2944813"},
      "location_type"=>"APPROXIMATE",
      "viewport"=>{"southwest"=>{"lat"=>"48.8570211", "lng"=>"2.2931323"}, "northeast"=>{"lat"=>"48.8597191", "lng"=>"2.2958303"}}
    },
    "place_id"=>"ChIJLU7jZClu5kcR4PcOOO6p3I0"
  }
}
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Copyright (c) 2013 Christian Kakesa. See LICENSE.txt for more details.
