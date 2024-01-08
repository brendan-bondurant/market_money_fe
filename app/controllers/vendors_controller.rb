class VendorsController < ApplicationController
  def show
    @facade = VendorFacade.new(params)
    # conn = Faraday.new(url: 'http://localhost:3000')
    # response = conn.get("/api/v0/vendors/#{params[:id]}")
    # json = JSON.parse(response.body, symbolize_names: true)
    # @vendor = Vendor.new(json[:data])
  end
  
  def market_search
    @facade = VendorFacade.new(params)

    @market_search = @facade.market_search
    
    if @market_search.nil?
      require 'pry'; binding.pry
      flash[:error] = "Name or City cannot be sent in on their own. Please provide other parameters to search for markets."
    end
    
    render 'show'
  end
end
# private

#   def search_params
#     if params[:state].present? && params[:city].present? && params[:name].present?
#       return "state=#{params[:state]}&city=#{params[:city]}&name=#{params[:name]}"
#     elsif 
#       params[:state].present? && params[:city].present?
#       return "state=#{params[:state]}&city=#{params[:city]}"
#     elsif
#       params[:state].present? && params[:name].present?
#       return "state=#{params[:state]}&name=#{params[:name]}"
#     elsif
#       params[:name].present? && params[:city].present? == false
#       return "name=#{params[:name]}"
#     elsif
#       params[:state].present?
#       return "state=#{params[:state]}"
#     end
#   end
# end