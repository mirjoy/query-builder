require 'uri'

class ApiService

  def self.call_api(query_string, entity)
    Faraday.default_adapter = :excon

    enc_uri = URI.escape("https://access.alchemyapi.com/calls/data/GetNews?apikey=#{ENV['alchemy_api_key']}&return=enriched.url.title&start=now-2d&end=now&q.enriched.url.enrichedTitle.entities.entity=|text=#{query_string},type=#{entity}|&count=15&outputMode=json")
    api_req = Faraday.get(enc_uri)

    JSON.parse(api_req.body)
  end
end
