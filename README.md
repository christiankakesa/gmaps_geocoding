# GmapsGeocoding

A simple Ruby gem for Google Maps Geocoding API.
This gem return a Ruby Hash object of the result.

## Installation

Add this line to your application's Gemfile:

    gem 'gmaps_geocoding'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gmaps_geocoding

## Usage
### Global information

See [Google Maps Geocoding service documentation](https://developers.google.com/maps/documentation/geocoding/) for options parameters and *result* handling.

### JSON example

    # json output example
    opts = {address: 'Tour Eiffel, Paris, IDF, France', output: 'json'}
    api = GmapsGeocoding::Api.new(opts)
    result = api.get_location

**Ruby Hash object from json output**

        {"results"=>
          [{"address_components"=>
             [{"long_name"=>"Eiffel Tower",
               "short_name"=>"Eiffel Tower",
               "types"=>["point_of_interest", "establishment"]},
              {"long_name"=>"Champ de Mars",
               "short_name"=>"Champ de Mars",
               "types"=>["premise"]},
              {"long_name"=>"5", "short_name"=>"5", "types"=>["street_number"]},
              {"long_name"=>"Avenue Anatole France",
               "short_name"=>"Av. Anatole France",
               "types"=>["route"]},
              {"long_name"=>"Paris",
               "short_name"=>"Paris",
               "types"=>["locality", "political"]},
              {"long_name"=>"Paris",
               "short_name"=>"75",
               "types"=>["administrative_area_level_2", "political"]},
              {"long_name"=>"Île-de-France",
               "short_name"=>"IdF",
               "types"=>["administrative_area_level_1", "political"]},
              {"long_name"=>"France",
               "short_name"=>"FR",
               "types"=>["country", "political"]},
              {"long_name"=>"75007", "short_name"=>"75007", "types"=>["postal_code"]}],
            "formatted_address"=>
             "Eiffel Tower, Champ de Mars, 5 Avenue Anatole France, 75007 Paris, France",
            "geometry"=>
             {"location"=>{"lat"=>48.858278, "lng"=>2.294254},
              "location_type"=>"APPROXIMATE",
              "viewport"=>
               {"northeast"=>{"lat"=>48.8656186, "lng"=>2.3102614},
                "southwest"=>{"lat"=>48.8509364, "lng"=>2.2782466}}},
            "types"=>["point_of_interest", "establishment"]},
           {"address_components"=>
             [{"long_name"=>"Eiffel Tower", "short_name"=>"Eiffel Tower", "types"=>[]},
              {"long_name"=>"Paris",
               "short_name"=>"Paris",
               "types"=>["locality", "political"]},
              {"long_name"=>"Paris",
               "short_name"=>"75",
               "types"=>["administrative_area_level_2", "political"]},
              {"long_name"=>"Île-de-France",
               "short_name"=>"IdF",
               "types"=>["administrative_area_level_1", "political"]},
              {"long_name"=>"France",
               "short_name"=>"FR",
               "types"=>["country", "political"]},
              {"long_name"=>"75007", "short_name"=>"75007", "types"=>["postal_code"]}],
            "formatted_address"=>"Eiffel Tower, 75007 Paris, France",
            "geometry"=>
             {"bounds"=>
               {"northeast"=>{"lat"=>48.858872, "lng"=>2.2952731},
                "southwest"=>{"lat"=>48.8578587, "lng"=>2.2937331}},
              "location"=>{"lat"=>48.8582222, "lng"=>2.2945},
              "location_type"=>"APPROXIMATE",
              "viewport"=>
               {"northeast"=>{"lat"=>48.8597143302915, "lng"=>2.295852080291502},
                "southwest"=>{"lat"=>48.8570163697085, "lng"=>2.293154119708498}}},
            "types"=>[]},
           {"address_components"=>
             [{"long_name"=>"Tour Eiffel", "short_name"=>"Tour Eiffel", "types"=>[]},
              {"long_name"=>"Paris",
               "short_name"=>"Paris",
               "types"=>["locality", "political"]},
              {"long_name"=>"Paris",
               "short_name"=>"75",
               "types"=>["administrative_area_level_2", "political"]},
              {"long_name"=>"Île-de-France",
               "short_name"=>"IdF",
               "types"=>["administrative_area_level_1", "political"]},
              {"long_name"=>"France",
               "short_name"=>"FR",
               "types"=>["country", "political"]},
              {"long_name"=>"75015", "short_name"=>"75015", "types"=>["postal_code"]}],
            "formatted_address"=>"Tour Eiffel, 75015 Paris, France",
            "geometry"=>
             {"location"=>{"lat"=>48.857269, "lng"=>2.291018},
              "location_type"=>"APPROXIMATE",
              "viewport"=>
               {"northeast"=>{"lat"=>48.8586179802915, "lng"=>2.292366980291502},
                "southwest"=>{"lat"=>48.8559200197085, "lng"=>2.289669019708498}}},
            "types"=>[]}],
         "status"=>"OK"}

### XML example

    # xml output example
    opts = {address: 'Tour Eiffel, Paris, IDF, France', output: 'xml'}
    api = GmapsGeocoding::Api.new(opts)
    result = api.get_location

**Ruby Hash object from xml output**

        {"status"=>"OK",
        "result"=>
        [{"type"=>["point_of_interest", "establishment"],
        "formatted_address"=>
         "Eiffel Tower, Champ de Mars, 5 Avenue Anatole France, 75007 Paris, France",
        "address_component"=>
         [{"long_name"=>"Eiffel Tower",
           "short_name"=>"Eiffel Tower",
           "type"=>["point_of_interest", "establishment"]},
          {"long_name"=>"Champ de Mars",
           "short_name"=>"Champ de Mars",
           "type"=>"premise"},
          {"long_name"=>"5", "short_name"=>"5", "type"=>"street_number"},
          {"long_name"=>"Avenue Anatole France",
           "short_name"=>"Av. Anatole France",
           "type"=>"route"},
          {"long_name"=>"Paris",
           "short_name"=>"Paris",
           "type"=>["locality", "political"]},
          {"long_name"=>"Paris",
           "short_name"=>"75",
           "type"=>["administrative_area_level_2", "political"]},
          {"long_name"=>"Île-de-France",
           "short_name"=>"IdF",
           "type"=>["administrative_area_level_1", "political"]},
          {"long_name"=>"France",
           "short_name"=>"FR",
           "type"=>["country", "political"]},
          {"long_name"=>"75007", "short_name"=>"75007", "type"=>"postal_code"}],
        "geometry"=>
         {"location"=>{"lat"=>"48.8582780", "lng"=>"2.2942540"},
          "location_type"=>"APPROXIMATE",
          "viewport"=>
           {"southwest"=>{"lat"=>"48.8509364", "lng"=>"2.2782466"},
            "northeast"=>{"lat"=>"48.8656186", "lng"=>"2.3102614"}}}},
        {"formatted_address"=>"Eiffel Tower, 75007 Paris, France",
        "address_component"=>
         [{"long_name"=>"Eiffel Tower", "short_name"=>"Eiffel Tower"},
          {"long_name"=>"Paris",
           "short_name"=>"Paris",
           "type"=>["locality", "political"]},
          {"long_name"=>"Paris",
           "short_name"=>"75",
           "type"=>["administrative_area_level_2", "political"]},
          {"long_name"=>"Île-de-France",
           "short_name"=>"IdF",
           "type"=>["administrative_area_level_1", "political"]},
          {"long_name"=>"France",
           "short_name"=>"FR",
           "type"=>["country", "political"]},
          {"long_name"=>"75007", "short_name"=>"75007", "type"=>"postal_code"}],
        "geometry"=>
         {"location"=>{"lat"=>"48.8582222", "lng"=>"2.2945000"},
          "location_type"=>"APPROXIMATE",
          "viewport"=>
           {"southwest"=>{"lat"=>"48.8570164", "lng"=>"2.2931541"},
            "northeast"=>{"lat"=>"48.8597143", "lng"=>"2.2958521"}},
          "bounds"=>
           {"southwest"=>{"lat"=>"48.8578587", "lng"=>"2.2937331"},
            "northeast"=>{"lat"=>"48.8588720", "lng"=>"2.2952731"}}}},
        {"formatted_address"=>"Tour Eiffel, 75015 Paris, France",
        "address_component"=>
         [{"long_name"=>"Tour Eiffel", "short_name"=>"Tour Eiffel"},
          {"long_name"=>"Paris",
           "short_name"=>"Paris",
           "type"=>["locality", "political"]},
          {"long_name"=>"Paris",
           "short_name"=>"75",
           "type"=>["administrative_area_level_2", "political"]},
          {"long_name"=>"Île-de-France",
           "short_name"=>"IdF",
           "type"=>["administrative_area_level_1", "political"]},
          {"long_name"=>"France",
           "short_name"=>"FR",
           "type"=>["country", "political"]},
          {"long_name"=>"75015", "short_name"=>"75015", "type"=>"postal_code"}],
        "geometry"=>
         {"location"=>{"lat"=>"48.8572690", "lng"=>"2.2910180"},
          "location_type"=>"APPROXIMATE",
          "viewport"=>
           {"southwest"=>{"lat"=>"48.8559200", "lng"=>"2.2896690"},
            "northeast"=>{"lat"=>"48.8586180", "lng"=>"2.2923670"}}}}]}


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Copyright (c) 2013 Christian Kakesa. See LICENSE.txt for more details.
