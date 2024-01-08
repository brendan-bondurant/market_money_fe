require 'faraday'

class MarketsController < ApplicationController
  
  def index
    @facade = MarketFacade.new(params)
  end

  def show
    @facade = MarketFacade.new(params)
  end
end

