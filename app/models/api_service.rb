require 'uri'

class ApiService

  def self.call_api(query_string, entity)
    enc_uri = URI.escape("https://access.alchemyapi.com/calls/data/GetNews?apikey=#{ENV['alchemy_api_key']}&return=enriched.url.title&start=now-2d&end=now&q.enriched.url.enrichedTitle.entities.entity=|text=#{query_string},type=#{entity}|&count=15&outputMode=json")
    api_req = Hurley.get(enc_uri) do |req|
      req.header[:accept] = "Accept-encoding: gzip"
    end

    JSON.parse(api_req.body)
  end
end
