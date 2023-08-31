class SearchController < ApplicationController
  def suggest
    query = params[:query]
    results = search_statmuse(query)

    render json: results
  end

  private

  def search_statmuse(query)
    uri = URI.parse("https://api.statmuse.com/search/suggest")
    timestamp = (Time.now.to_f * 1000).to_i
    uri.query = URI.encode_www_form({ query: query, timestamp: timestamp })

    response = Net::HTTP.get_response(uri)

    if response.is_a?(Net::HTTPSuccess)
      data = JSON.parse(response.body)
      return data.take(5)
    else
      return []
    end
  end
end
