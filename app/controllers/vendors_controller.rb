class VendorsController < ApplicationController
  def show
    conn = Faraday.new(url: 'http://localhost:3000')
    response = conn.get("/api/v0/vendors/#{params[:id]}")
    json = JSON.parse(response.body, symbolize_names: true)
    @vendor = Vendor.new(json[:data])
  end

  def market_search
    conn = Faraday.new(url: 'http://localhost:3000')
    vendor_response = conn.get("/api/v0/vendors/#{params[:vendor_id]}")
    vendor = JSON.parse(vendor_response.body, symbolize_names: true)
    @vendor = Vendor.new(vendor[:data])
    if search_params != nil
      response = conn.get("/api/v0/markets/search?#{search_params}")
      json = JSON.parse(response.body, symbolize_names: true)
      @market_search = json[:data].map do |market_info|
        # require 'pry'; binding.pry
        Market.new(market_info)
      end
      render 'show'
    else
      flash[:error] = "Name or City cannot be sent in on their own. Please provide other parameters to search for markets."
      render 'show'
  end
end
private

  def search_params
    if params[:state].present? && params[:city].present? && params[:name].present?
      return "state=#{params[:state]}&city=#{params[:city]}&name=#{params[:name]}"
    elsif 
      params[:state].present? && params[:city].present?
      return "state=#{params[:state]}&city=#{params[:city]}"
    elsif
      params[:state].present? && params[:name].present?
      return "state=#{params[:state]}&name=#{params[:name]}"
    elsif
      params[:name].present? && params[:city].present? == false
      return "name=#{params[:name]}"
    elsif
      params[:state].present?
      return "state=#{params[:state]}"
    end
  end
end