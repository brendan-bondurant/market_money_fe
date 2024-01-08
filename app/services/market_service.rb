class MarketService

  def conn
    Faraday.new(url: 'http://localhost:3000')
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def all_markets
    get_url('/api/v0/markets')
  end

  def one_market(id)
    get_url("/api/v0/markets/#{id}")
  end

  def vendors(id)
    get_url("/api/v0/markets/#{id}/vendors")
  end
end