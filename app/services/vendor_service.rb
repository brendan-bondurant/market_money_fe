class VendorService

  def conn
    Faraday.new(url: 'http://localhost:3000')
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def one_vendor(id)
    get_url("/api/v0/vendors/#{id}")
  end

  def search_add_markets(params)
    get_url("/api/v0/markets/search?#{params}")
  end
end