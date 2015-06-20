require 'uri'

class ApiService

  def self.call_api(query_string, entity)
    Faraday.default_adapter = :excon
    enc_uri = URI.escape("https://access.alchemyapi.com/calls/data/GetNews?apikey=#{ENV['alchemy_api_key']}")

    api_req = Faraday.get(enc_uri) do |req|
      req.params["return"] = "enriched.url.title,enriched.url.url,enriched.url.enrichedTitle.docSentiment,enriched.url.enrichedTitle.taxonomy"
      req.params["start"] = "now-10d"
      req.params["end"] = "now"
      req.params["q.enriched.url.enrichedTitle.entities.entity"] = "|text=#{query_string},type=#{entity}|"
      req.params["count"] = "15"
      req.params["outputMode"] = "json"
    end

    JSON.parse(api_req.body)
  end
end
