require 'faraday'

class MarketsController < ApplicationController
  
  def index
    conn = Faraday.new(url: 'http://localhost:3000')
    response = conn.get('/api/v0/markets')
    json = JSON.parse(response.body, symbolize_names: true)
    @markets = json[:data].map do |market_info|
      Market.new(market_info)
    end

  end

  def show
    conn = Faraday.new(url: 'http://localhost:3000')
    response = conn.get("/api/v0/markets/#{params[:id]}")
    json = JSON.parse(response.body, symbolize_names: true)
    @market = Market.new(json[:data])
    # Get the vendors associated with the market
    vendors_response = conn.get("/api/v0/markets/#{params[:id]}/vendors")
    vendors_json = JSON.parse(vendors_response.body, symbolize_names: true)
    @vendors = vendors_json[:data].map do |vendor|
      Vendor.new(vendor)
    end
  end

  # def search
  #   require 'pry'; binding.pry
  #   conn = Faraday.new(url: 'http://localhost:3000')
  #   response = conn.get("/api/v0/markets/search?#{search_params}")
  #   json = JSON.parse(response.body, symbolize_names: true)
  #   @market_search = json[:data]

  # end
end

