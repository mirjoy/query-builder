class ApiService

  def self.call_api(query_string, entity)
    connection = Faraday.new("https://access.alchemyapi.com/calls/data/GetNews?apikey=#{ENV['alchemy_api_key']}&start=now-10d&end=now&count=15&outputMode=json")
    api_req = connection.get do |req|
      req.params['q.enriched.url.enrichedTitle.entities.entity'] = '|text=#{query_string},type=#{entity}|'
    end

    JSON.parse(api_req)
  end
end
