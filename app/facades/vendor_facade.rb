class VendorFacade
  attr_reader :vendor
  def initialize(params)
    @params = params
    @vendor_service = VendorService.new
    # @vendor = vendor
  end

  def vendor
    @vendor ||= begin
      json = @vendor_service.one_vendor(@params[:id])
      Vendor.new(json[:data])
    end
  end

  def market_search
    if (@params[:commit] == "Search Markets") && search_params != nil
      vendor_info = @vendor_service.one_vendor(@params[:vendor_id])
      @vendor = Vendor.new(vendor_info[:data])
      json = @vendor_service.search_add_markets(search_params)
      market_search_results = json[:data].map { |market_info| Market.new(market_info) }
    end
  end

  private

  def search_params
    params = @params
    if params[:state].present? && params[:city].present? && params[:name].present?
      return "state=#{params[:state]}&city=#{params[:city]}&name=#{params[:name]}"
    elsif params[:state].present? && params[:city].present?
      return "state=#{params[:state]}&city=#{params[:city]}"
    elsif params[:state].present? && params[:name].present?
      return "state=#{params[:state]}&name=#{params[:name]}"
    elsif params[:name].present? && params[:city].present? == false
      return "name=#{params[:name]}"
    elsif params[:state].present?
      return "state=#{params[:state]}"
    end
  end

end