class MarketFacade 
  def initialize(params)
    @params = params
  end

  def markets
    markets = MarketService.new
    json = markets.all_markets
    markets = json[:data].map do |market_info|
      Market.new(market_info)
    end
  end

  def market
    market = MarketService.new
    json = market.one_market("#{@params[:id]}")
    market = Market.new(json[:data])
  end

  def vendors
    market = MarketService.new
    json = market.vendors("#{@params[:id]}")
    vendors = json[:data].map do |vendor_info|
      Vendor.new(vendor_info)
    end
  end
end