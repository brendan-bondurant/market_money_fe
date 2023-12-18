require 'rails_helper'

# As a visitor,
# When I visit a market's show page 'markets/:id'
# I see that market's name and readable address
# And I also see a list of all the Vendors that are at that market
# Each vendor name is a link to that vendor's show page

RSpec.describe 'markets#show', type: :feature do
  
  it 'lists their name, city, and state' do
    visit market_path("322458")
    expect(page).to have_content("14&U Farmers' Market")
    expect(page).to have_content("1400 U Street NW ")
    expect(page).to have_content("Washington")
    expect(page).to have_content("District of Columbia")
    expect(page).to have_content("The Charcuterie Corner")
    expect(page).to have_link("The Charcuterie Corner")
    click_link("The Charcuterie Corner")
    expect(current_path).to eq(vendor_path("55823"))

  end
end