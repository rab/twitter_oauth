module TwitterOAuth
  class Client

    # Search for places (cities and neighborhoods) that can be attached to a
    # statuses/update.
    #
    # Given a latitude (-90.0 .. +90.0) and a longitude (-180.0 .. +180.0),
    # return a list of all the valid places that can be used as a place_id
    # when updating a status
    #
    # Options:
    #  :accuracy    => number, "#{number}m", "#{number}ft" (plain number is meters; default: 0)
    #  :granularity => poi, neighborhood, city, admin, country (default: neighborhood)
    #  :max_results => Just a hint, but should be the number that will be displayed.
    #  :callback
    #    => If supplied, the response will use the JSONP format with a callback of the given name.
    #
    # see http://dev.twitter.com/doc/get/geo/reverse_geocode
    def reverse_geocode(lat, lng, options={})
      options[:lat] = lat; options[:long] = lng
      args = options.map{|k,v| "#{k}=#{v}"}.join('&')
      get "/geo/reverse_geocode.json?#{args}"
    end

    # Search for places (cities and neighborhoods) that can be attached to a
    # statuses/update.
    #
    # Given a latitude and a longitude pair, or an IP address, return a list
    # of all the valid cities and neighborhoods that can be used as a place_id
    # when updating a status.
    #
    # Options:
    #  :ip    => An IP address
    #  :lat   => The latitude to search around. -90.0 .. +90.0
    #  :long  => The longitude to search around. -180.0 .. +180.0
    #  :query => Free-form text. (Remember to URL encode the query.)
    #  :granularity => poi, neighborhood, city, admin, country (default: neighborhood)
    #  :accuracy    => number, "#{number}m", "#{number}ft" (plain number is meters; default: 0)
    #  :max_results => Just a hint, but should be the number that will be displayed.
    #  :callback
    #    => If supplied, the response will use the JSONP format with a callback of the given name.
    #  :contained_within => A place_id which you would like to restrict the search results to.
    #  'attribute:street_address' => (see doc page)
    #
    # see http://dev.twitter.com/doc/get/geo/search
    def geo_search(options={})
      options[:query] = URI.escape(options[:query]) if options[:query]
      args = options.map{|k,v| "#{k}=#{v}"}.join('&')
      get "/geo/search.json?#{args}"
    end

    # Find out more details of a place that was returned from the
    # geo/reverse_geocode method.
    #
    # see http://dev.twitter.com/doc/get/geo/id/:place_id
    def geo(place_id)
      get "/geo/id/#{place_id}.json"
    end

  end
end
