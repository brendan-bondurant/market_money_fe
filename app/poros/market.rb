class Market
  attr_reader :name, :city, :state, :id, :street, :address, :zip

  def initialize(data)
    @name = data[:attributes][:name]
    @city = data[:attributes][:city]
    @state = data[:attributes][:state]
    @street = data[:attributes][:street]
    @address = data[:attributes][:address]
    @zip = data[:attributes][:zip]
    @id = data[:id]
  end
end