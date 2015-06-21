require 'uri'

class ApiService
# https://access.alchemyapi.com/calls/data/GetNews?apikey=YOUR_API_KEY_HERE&return=enriched.url.title&start=1434240000&end=1434927600&q.enriched.url.cleanedTitle=apple&count=25&outputMode=json
# https://access.alchemyapi.com/calls/data/GetNews?apikey=YOUR_API_KEY_HERE&return=enriched.url.title&start=1434240000&end=1434927600&q.enriched.url.enrichedTitle.entities.entity=|text=apple,type=person|&count=25&outputMode=json

  def self.call_api(query_string, entity)
    Faraday.default_adapter = :excon
    enc_uri = URI.escape("https://access.alchemyapi.com/calls/data/GetNews?apikey=#{ENV['alchemy_api_key']}")

    api_req = Faraday.get(enc_uri) do |req|
      req.params["return"] = "enriched.url.title,enriched.url.url,enriched.url.enrichedTitle.docSentiment,enriched.url.enrichedTitle.taxonomy,enriched.url.enrichedTitle.entities,enriched.url.enrichedTitle.entities,enriched.url.enrichedTitle.keywords,enriched.url.text"
      req.params["start"] = "now-5d"
      req.params["end"] = "now"
      if entity != "anything"
        req.params["q.enriched.url.enrichedTitle.entities.entity"] = "|text=#{query_string},type=#{entity}|"
      else
        req.params["q.enriched.url.cleanedTitle"] = "#{query_string}"
      end
      req.params["count"] = "15"
      req.params["outputMode"] = "json"
    end

    JSON.parse(api_req.body)
  end

end
